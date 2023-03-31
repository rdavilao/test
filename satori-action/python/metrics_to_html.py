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
        print("![](http://www.plantuml.com/plantuml/png/SoWkIImgAStDuNBAJrBGjLDmpCbCJbMmKiX8pSd9vt99pCCKT4ZDIm7g0000)")
        print("<img src='1.jpg' alt='Girl in a jacket'>")
        print("# Chatbot Metrics")
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
