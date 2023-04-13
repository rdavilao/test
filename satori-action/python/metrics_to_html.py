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
        print("![](http://www.plantuml.com/plantuml/png/XP31IiGm48RlynHp5XO4Rx8iUn8yUnGfqtIsBMqc8Ps2HNntewpQ3MbpoU7_lZypoNbI2ZhR4QQX5q-1B9gHfWa_u7ELYMluXJq-tECg3IJ3Rzhr3IDRhmjQjZM72J6wIifey7WqdUiDdqxmUlTsE9mCc7ZEgXogDZ1hHKPx9vNok-8Z_cImpVDai_4tophNV6DAB_m7K33tSDfDbuYFBwveEexdx6yscwKZxnV8AvaqPvP_WIvziBlLDbRhXPDUmxB0dh39ygtLTvd2w6kwycgdSNaQHvOsjMyObFs20Hc--uPBb6eoGpBcwHe_Yx8exBgRCErb5ZcpDBCTlm00)")
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