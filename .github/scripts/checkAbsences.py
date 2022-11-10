#!/usr/bin/env python3
import csv
import sys
from datetime import datetime

def main(): 
    # get current year/month and day
    month = datetime.today().strftime('%Y-%m')
    day = datetime.today().strftime('%d')
    # 

    check_who_here = False
    absent = []
    with open('AIMCalander.csv', mode='r') as file:
        csv_reader = csv.reader(file)
        for row in csv_reader:
            if row[0] == "":
                check_who_here=False   
            if check_who_here and row[int(day)]!="":
                absent.append(row[0])
            if row[0] == month:
                check_who_here=True

    # return array of who's not here to bash
    sys.exit(absent)

if __name__ == "__main__":
    main()