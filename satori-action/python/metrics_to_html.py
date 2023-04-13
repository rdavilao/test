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
        print("# Chatbot conversation flow")
        print("![](www.plantuml.com/plantuml/png/XP31IiGm48RlynHp5XO4Rx8iUn8yUnGfqtIsBMqc8Ps2HNntewpQ3MbpoU7_lZypoNbI2ZhR4M0QUl4KoA8PQPhm0pvNcRY6NzZZmpskqa0o_APTtp2ozRgWPLjpc12ZgwIC1ez7qxdUyEa4htTlXyF9W8ddhCgXQWEpLcIqTr8floi-uay6spnFDXj_iwnppJUczC9_00Lp3wVTT8du-EAAfkDuplvcirawydw1l999SsRv5-ZI1xjRRMErNZZfDImBx0cR35AIVfSfZBwcAwzs6fUdSMHfK_k6GTal6B3Dys-uHAacCoHZdgxnioYBmgwx3PDUPX4uipIp7Ry0)")
        print("# Chatbot Metrics")
        print("<table>", file=output)
        print("<thead>")
        print("<tr>")        
        print("<th>Name</th>")
        print("<th>Value</th>")
        print("<th>Result</th>")
        print("</tr>")
        print("</thead>")

        global_metrics = data["Global Metrics"]
        for key in global_metrics:
            print("<tr>", file=output)

            print("<td>", file=output)
            print(key, file=output)
            print("</td>", file=output)

            print("<td>", file=output)
            print(global_metrics[key], file=output)
            print("</td>", file=output)
            
            print("<td>✅</td>")
        
            print("</tr>", file=output)
        print("</table>", file=output)
    
    print("<h4>For more information on the interpretation of these matrices, please visit:  <a href='http://miso.ii.uam.es/asymobService/metrics.html'>asymob</a></h4>")