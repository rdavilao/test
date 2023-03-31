from argparse import ArgumentParser

import json
import sys

if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument("-f", "--file", dest="filename",
                        help="write report to FILE", metavar="FILE")

    args = parser.parse_args()

    output = sys.stdout
    
    with open(args.filename, 'r') as f:
        data = json.load(f)
        print("<h1>Chatbot conversation flow:</h1>")
        print("<img style='display: block; margin-left: auto; margin-right: auto;' src='https://randomuser.me/api/portraits/lego/1.jpg' width='300' height='300'>")
        print("<h1>Chatbot Metrics:</h1>")
        print("<table>", file=output)
        global_metrics = data["Global Metrics"]
        for key in global_metrics:
            print("<tr>", file=output)

            print("<td>", file=output)
            print(key, file=output)
            print("</td>", file=output)

            print("<td>", file=output)
            print(global_metrics[key], file=output)
            print("</td>", file=output)
        
            print("</tr>", file=output)
        print("</table>", file=output)
