# This files contains your custom actions which can be used to run
# custom Python code.
#
# See this guide on how to implement these action:
# https://rasa.com/docs/rasa/custom-actions


from argparse import Action
from email import message
from pydoc import synopsis
import string
import random
from typing import Text, Dict, Any, List
from rasa_sdk import Action, Tracker, FormValidationAction
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.events import SlotSet, AllSlotsReset
from rasa_sdk.types import DomainDict
import mysql.connector

#Class contains database connection methods/ some helper methods
class dbConnection():
    
    def insertIntoDataBase(query, values):
        connection = mysql.connector.connect(host="localhost",user="root",password="Bucky!", database="Cinema")
        if connection.is_connected():
            mydb = connection.cursor()
            mydb.execute(query, values)
            connection.commit()
            connection.close()
    
    def retriveFromDataBase(query):
        connection = mysql.connector.connect(host="localhost",user="root",password="Bucky!", database="Cinema")
        if connection.is_connected():
            mydb = connection.cursor()
            mydb.execute(query)
            result = mydb.fetchall()
            connection.close()
            return result

class helperMethods():
        #Some helper functions to avoid repetition/clear code up a little bit
    def generateBookingReferences():
        referenceQuery = "SELECT bookingid FROM booking"
        referenceResults = dbConnection.retriveFromDataBase(referenceQuery)
        while True:
            numbers = string.digits
            letters = string.ascii_uppercase
            selectedLetters = "".join(random.choice(letters) for i in range(2))
            newBooking = "".join(random.choice(numbers) for i in range(7))
            newBooking = newBooking + selectedLetters
            if newBooking not in referenceResults:
                break

        return newBooking

    def splitDateTime(dateTime):
        date = dateTime[0:10]
        time = dateTime[11:19]
        return [date, time]

    def getShowingID(movie, date, time):
        showingIDQuery = "SELECT showing.showingid FROM showing JOIN movie ON movie.movieid = showing.movie_id WHERE (movie.movie_title = '{0}') AND (showing.movie_date = '{1}') AND (showing.movie_time = '{2}')".format(movie, date, time)
        showingIDresults = dbConnection.retriveFromDataBase(showingIDQuery)
        if len(showingIDresults) == 1:
            showingID = showingIDresults[0][0]
            return showingID
        else:
            return []


#Action for retriving  information about specific movies
class ActionQueryMovie(Action):

    def name(self) -> Text:
        return "action_query_movie"

    def run(self,dispatcher: CollectingDispatcher,tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        
        movie = tracker.get_slot('movie_name')
        q = "select * from movie where movie_title='{0}' limit 1".format(movie)
        
        result = dbConnection.retriveFromDataBase(q)
        if result != []:
            message = "{0}\n Synopsis: {1}\n Runtime: {2}\n Average Review: {3}%\n Age Rating: {4}\n Director(s): {5} ".format(movie, result[0][3],result[0][2],result[0][4],result[0][5],result[0][6])
            dispatcher.utter_message(text=message)
        else:
            message = "Sorry we are not showing {0} right now".format(movie)
            dispatcher.utter_message(text=message)
        return [SlotSet("movie_name", None)]



#Insert booking into database
class ActionInputBooking(Action):
    def name(self) -> Text:
        return "action_input_booking"

    def run(self,dispatcher: CollectingDispatcher,tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        seatID = []
        num_tickets = tracker.get_slot('num_tickets')
        bookingID = helperMethods.generateBookingReferences()
        date, time = helperMethods.splitDateTime(tracker.get_slot('start_time'))
        num_seats = tracker.get_slot('num_tickets')
        movie = tracker.get_slot('movie_name')
        showingID = helperMethods.getShowingID(movie,date,time)

        queryBooked = "INSERT INTO booking (bookingid, showing_id, booked, paid, active, num_seats, collected) VALUES (%s, %s, %s, %s, %s, %s, %s)"
        bookedValues = (bookingID, showingID, True, False, True, num_seats, False)
        
        totalSeatIDQuery = "SELECT seat.seatid FROM seat right JOIN showing ON seat.screen_id = showing.screen_id WHERE showing.showingid = '{0}'".format(showingID)
        totalSeatIDResults = dbConnection.retriveFromDataBase(totalSeatIDQuery)
        
        bookedSeatIDQuery = "SELECT seat_id FROM seat_booked WHERE showing_id = '{0}'".format(showingID)
        bookedSeatIDResults = dbConnection.retriveFromDataBase(bookedSeatIDQuery)
        availableSeats = []
        print(bookedSeatIDResults)
        for id in totalSeatIDResults:
            
            if id not in bookedSeatIDResults:
                availableSeats.append(id[0])

        dbConnection.insertIntoDataBase(queryBooked, bookedValues)
        if len(availableSeats) >= num_tickets:
            for x in availableSeats[:num_seats]:
                seatID.append(x)
                
            for i in range(num_seats):
                valuesSeatBooked = (seatID[i],bookingID,showingID)
                querySeatBooked = "INSERT INTO seat_booked (seat_id, booking_id, showing_id) VALUES (%s, %s, %s)"
                dbConnection.insertIntoDataBase(querySeatBooked, valuesSeatBooked)
            

            return [SlotSet("too_many_tickets", False),SlotSet("booking_reference", bookingID)]
 
        elif len(availableSeats) == 0:
            message = "Sorry there are no seats left for this showing, would you like to select another showings"
            dispatcher.utter_message(text=message)
            return [SlotSet("start_time", None), SlotSet("too_many_tickets", True), SlotSet("num_tickets", None)]
        else:
            message = "There is only {0} seat(s) left for this showing, would you like to book a different showing?".format(len(availableSeats))
            dispatcher.utter_message(text=message)
            return [SlotSet("start_time", None), SlotSet("too_many_tickets", True), SlotSet("num_tickets", None)]
        
        

class ActionUtterTotalPrice(Action):
    def name(self) -> Text:
        return "action_utter_total_price"
    
    def run(self,dispatcher: CollectingDispatcher,tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        num_tickets = tracker.get_slot('num_tickets')
        movie = tracker.get_slot('movie_name')
        date, time = helperMethods.splitDateTime(tracker.get_slot('start_time'))
        showingID = helperMethods.getShowingID(movie, date, time)
        query = "SELECT screen_id FROM showing WHERE showingid = '{0}'".format(showingID)
        queryResult = dbConnection.retriveFromDataBase(query)
        priceQuery = "SELECT price FROM seat WHERE screen_id = '{0}'".format(queryResult[0][0])
        priceResult = dbConnection.retriveFromDataBase(priceQuery)
        price = priceResult[0][0]
        price = price * num_tickets
        message = "The total price for this purchase comes to £" + str(price)
        dispatcher.utter_message(text=message)
        return []
  

#Created this instead of using built in response system, since start_time enitiy needs to be made more readable otherwise prints as DD/MM/YYYYT00:00:00-00:00
class ActionUtterConfirmation(Action):
        def name(self) -> Text:
            return "action_utter_confirmation"

        def run(self,dispatcher: CollectingDispatcher,tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
            num_seats = tracker.get_slot('num_tickets')
            movie = tracker.get_slot('movie_name')
            date, time = helperMethods.splitDateTime(tracker.get_slot('start_time'))
            message = "To confirm the details: {0} ticket(s) for {1} on {2} at {3}. Is this correct? ".format(num_seats, movie, date, time)
            dispatcher.utter_message(text=message)
            return []
        

#Validates information that is input into the booking form
class ValidateBookingForm(FormValidationAction):
    def name(self) -> Text:
        return "validate_booking_form"

    @staticmethod
    def movie_db() -> List[Text]:
        """Database of supported movies"""

        return ["captain america: the winter soldier" , "2001: a space odyssey", "spider-man: into the spider-verse", "your name (subtitled)",  "avengers: infinity war", "thor: ragnarok"]

    def validate_movie_name(self, slot_value: Any, dispatcher: CollectingDispatcher,tracker: Tracker,domain: DomainDict,) -> Dict[Text, Any]:
        """Validate movie_name value."""
        print(tracker.get_slot('movie_name').lower())
        print(self.movie_db())
        if tracker.get_slot('movie_name').lower() in self.movie_db():
            # validation succeeded, set the value of the "cuisine" slot to value
            return {"movie_name": tracker.get_slot('movie_name')}
            
        else:
            # validation failed, set this slot to None so that the
            # user will be asked for the slot again
            message = "Sorry, " + slot_value + " does not exist."
            dispatcher.utter_message(text=message)
            print('done')
            return {"movie_name": None}

    def validate_start_time(self, slot_value: Any, dispatcher: CollectingDispatcher,tracker: Tracker,domain: DomainDict,) -> Dict[Text, Any]:
        """Validate start_time value."""
        date, time = helperMethods.splitDateTime(tracker.get_slot('start_time'))

        showingID = helperMethods.getShowingID(tracker.get_slot('movie_name'),date,time)
        if showingID == []:
            # validation succeeded, set the value of the "cuisine" slot to value
           message = "Sorry there is no showing at this time for that movie"
           dispatcher.utter_message(text=message)
           return {"start_time": None}
        else:
            # validation failed, set this slot to None so that the
            # user will be asked for the slot again
            
            return {"start_time": tracker.get_slot('start_time')}

    def validate_num_tickets(self, slot_value: Any, dispatcher: CollectingDispatcher,tracker: Tracker,domain: DomainDict,) -> Dict[Text, Any]:
        """Validate num_tickets value."""

        if tracker.get_slot('num_tickets') < 0:
            # validation succeeded, set the value of the "cuisine" slot to value
            message = "You must enter a valid number of tickets!"
            dispatcher.utter_message(text=message)
            return {"num_tickets": None}
        elif tracker.get_slot('num_tickets') > 15:
            message = "Sorry, you can only purchase up to 15 tickets at once"
            dispatcher.utter_message(text=message)
            return {"num_tickets": None}
        else:
            return {"num_tickets": tracker.get_slot('num_tickets')}

    


#This action when called will reset every slot to null 
class ClearSlots(Action):
    def name(self) -> Text:
        return "action_clear_slots"

    def run(self,dispatcher: CollectingDispatcher,tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        connection = mysql.connector.connect(host="localhost",user="root",password="Bucky!", database="Cinema")
        print("HEREEEE")
        if connection.is_connected():
            mydb = connection.cursor()
            
            mydb.execute("DELETE seat_booked FROM seat_booked INNER JOIN booking ON seat_booked.booking_id = booking.bookingid WHERE booking.paid = False")
            mydb.execute("DELETE FROM booking WHERE paid = False ")
            connection.close()

        return [AllSlotsReset()]


class ActionDisplaySchedule(Action):
    def name(self) -> Text:
        return "action_utter_movie_schedule"

    def run(self,dispatcher: CollectingDispatcher,tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        movie = tracker.get_slot('movie_name')
        day, time = helperMethods.splitDateTime(tracker.get_slot('start_time'))
        screenType = ['IMAX', '3D' , '2D']
        message = "Times for " + day + ": \n"
        for type in screenType:
            message += type + '\n'
            timesQuery = "SELECT movie_time FROM showing INNER JOIN screen ON showing.screen_ID = screen.screenid INNER JOIN movie ON showing.movie_id = movie.movieid WHERE movie.movie_title = '{0}' AND showing.movie_date = '{1}' AND screen.screen_type = '{2}'".format(movie, day, type)
            timesResults = dbConnection.retriveFromDataBase(timesQuery)
            if len(timesResults) == 0:
                message += "No times avaliable \n"
            else:
                timeList =[]
                for time in timesResults:
                    timeList.append(str(time[0]))
                timeList = ", ".join(timeList)
                message += timeList + "\n"

        dispatcher.utter_message(text=message)
        return [AllSlotsReset()]


class ValidateCollectionForm(FormValidationAction):
    def name(self) -> Text:
        return "validate_collection_form"

    def validate_booking_reference(self, slot_value: Any, dispatcher: CollectingDispatcher,tracker: Tracker,domain: DomainDict,) -> Dict[Text, Any]:
        """Validate booking_reference value."""

        if len(tracker.get_slot('booking_reference')) == 9:
            # validation succeeded, set the value of the "cuisine" slot to value
            collectionQuery = "SELECT bookingid, collected FROM booking WHERE bookingid ='{0}'".format(tracker.get_slot('booking_reference'))
            collectionResults = dbConnection.retriveFromDataBase(collectionQuery)
            if len(collectionResults) == 1:
                if collectionResults[0][1] == False:
                    return {"booking_reference": collectionResults[0][0]}
                else:
                    message = "Sorry, It seems that these tickets have already been collected."
                    dispatcher.utter_message(text=message)
                    return {"booking_reference": None}
            else:
                message = "Sorry, I'm having trouble finding the booking reference " + slot_value + " in our system, could you please try again."
                dispatcher.utter_message(text=message)
                return {"booking_reference": None}
        else:
            # validation failed, set this slot to None so that the
            # user will be asked for the slot again
            message = "Please re-enter a valid booking reference"
            dispatcher.utter_message(text=message)
            return {"booking_reference": None}


class ValidatePaymentForm(FormValidationAction):
    def name(self) -> Text:
        return "validate_payment_form"

    def validate_card_num(self, slot_value: Any, dispatcher: CollectingDispatcher,tracker: Tracker,domain: DomainDict,) -> Dict[Text, Any]:
        """Validate card_num value."""

        if len(tracker.get_slot('card_num')) == 16 and tracker.get_slot('card_num').isnumeric():
            # validation succeeded, set the value of the "cuisine" slot to value
          
            return {"card_num": tracker.get_slot('card_num')}
          
        else:
            # validation failed, set this slot to None so that the
            # user will be asked for the slot again
            message = "Please re-enter a valid card number"
            dispatcher.utter_message(text=message)
            return {"card_num": None}

    def validate_sort_code(self, slot_value: Any, dispatcher: CollectingDispatcher,tracker: Tracker,domain: DomainDict,) -> Dict[Text, Any]:
        """Validate sort_code value."""
        sortCode = tracker.get_slot('sort_code')
        if len(sortCode) == 8:
            # validation succeeded, set the value of the "cuisine" slot to value
            if sortCode[2] == "-" and sortCode[5] == "-":
                return {"sort_code": tracker.get_slot('sort_code')}
          
        else:
            # validation failed, set this slot to None so that the
            # user will be asked for the slot again
            message = "Please re-enter a valid sort code (format is XX-XX-XX)"
            dispatcher.utter_message(text=message)
            return {"sort_code": None}

    def validate_cvv(self, slot_value: Any, dispatcher: CollectingDispatcher,tracker: Tracker,domain: DomainDict,) -> Dict[Text, Any]:
        """Validate cvv value."""
        cvv = tracker.get_slot('cvv')
        if len(cvv) == 3 and cvv.isnumeric():
            # validation succeeded, set the value of the "cuisine" slot to value
            
            return {"cvv": tracker.get_slot('cvv')}
          
        else:
            # validation failed, set this slot to None so that the
            # user will be asked for the slot again
            message = "Please re-enter a valid cvv numer (should be 3 digits long)"
            dispatcher.utter_message(text=message)
            return {"cvv": None}


class ActionUtterMovies(Action):
    def name(self) -> Text:
            return "action_utter_movies"

    def run(self,dispatcher: CollectingDispatcher,tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        movies = ""
        movieQuery = "SELECT movie_title FROM movie"
           
        movieResults = dbConnection.retriveFromDataBase(movieQuery)
        for movie in movieResults:
            movies += movie[0] + ", "
        message = "We are currently showing: {0} ".format(movies)
        dispatcher.utter_message(text=message)
        return []    

#If was deployed would be used for payment gateway API
class ActionInputPayment(Action):
    def name(self) -> Text:
            return "action_input_payment"
    
    def run(self,dispatcher: CollectingDispatcher,tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        bookingID = tracker.get_slot('booking_reference')
        bookingQuery = "UPDATE booking SET paid = %s WHERE bookingid = %s"
        val = (bookingID, 'True')
        dbConnection.insertIntoDataBase(bookingQuery, val)
        message = "Payment Accepted, Your booking Reference is: " + bookingID
            
        dispatcher.utter_message(text=message)
        return [SlotSet("card_num", None), SlotSet("sort_code", None), SlotSet("cvv", None)]


class ActionInputCollection(Action):
    def name(self) -> Text:
            return "action_input_collection"
    
    def run(self,dispatcher: CollectingDispatcher,tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        bookingID = tracker.get_slot('booking_reference')
        bookingQuery = "SELECT collected FROM booking WHERE bookingid = '{0}'".format(bookingID)
        
        bookingResult = dbConnection.retriveFromDataBase(bookingQuery)
        collected = bookingResult[0][0]
        if not collected:
            message = "Your tickets will be printed shortly!"
            dispatcher.utter_message(text=message)
           
            return [SlotSet('collected', True)]    
        else:
            message = "Your tickets have already been collected before, please try another booking reference!"
            dispatcher.utter_message(text=message)
            return [SlotSet('collected', False)]    
            


class ValidateMovieScheduleForm(FormValidationAction):
    def name(self) -> Text:
        return "validate_movie_schedule_form"

    @staticmethod
    def movie_db() -> List[Text]:
        """Database of supported movies"""

        return ["captain america: the winter soldier" , "2001: a space odyssey", "spider-man: into the spider-verse", "your name (subtitled)",  "avengers: infinity war", "thor: ragnarok"]

    def validate_movie_name(self, slot_value: Any, dispatcher: CollectingDispatcher,tracker: Tracker,domain: DomainDict,) -> Dict[Text, Any]:
        """Validate movie_name value."""
        if tracker.get_slot('movie_name').lower() in self.movie_db():
            # validation succeeded, set the value of the "cuisine" slot to value
            return {"movie_name": tracker.get_slot('movie_name')}
            
        else:
            # validation failed, set this slot to None so that the
            # user will be asked for the slot again
            message = "Sorry, we are not showing " + slot_value + " right now "
            dispatcher.utter_message(text=message)
            return {"movie_name": None}


#If cinebot was deployed in a real world cinema then this would print the ticket, just pretends for now
class ActionPrintTicket(Action):
    def name(self) -> Text:
            return "action_print_ticket"
    
    def run(self,dispatcher: CollectingDispatcher,tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        bookingID = tracker.get_slot('booking_reference')
        bookingQuery = "UPDATE booking SET collected = %s WHERE bookingid = %s"
        val = (bookingID, True)
        dbConnection.insertIntoDataBase(bookingQuery, val)
        dispatcher.utter_message(text="Printing your ticket(s) now")
        dispatcher.utter_message(text="https://cdn.dribbble.com/users/400493/screenshots/7322525/ticket.gif")
        dispatcher.utter_message(text="Your ticket(s) have been printed")
        return [AllSlotsReset()]    



class ActionDisplayBooking(Action):
    def name(self) -> Text:
            return "action_display_booking"

    def run(self,dispatcher: CollectingDispatcher,tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        bookingID = tracker.get_slot('booking_reference')
        bookingQuery = "SELECT booking.bookingid, booking.num_seats, showing.screen_id, movie.movie_title FROM booking JOIN showing ON booking.showing_id = showing.showingId JOIN movie ON showing.movie_id = movie.movieid WHERE booking.bookingid = '{0}'".format(bookingID)
        results = dbConnection.retriveFromDataBase(bookingQuery)
        if len(results) == 1:
            message = "Details for booking reference: {0}\n Movie Name: {1}\n Number of Seats: {2}\n Screen {3}".format(results[0][0], results[0][3], results[0][1], results[0][2])
            dispatcher.utter_message(text=message)
        else:
            dispatcher.utter_message(text="I'm sorry, It seems I can't find your booking reference")
        return [SlotSet('booking_reference', None)] 