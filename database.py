import mysql.connector
from sys import argv
import random

class Script:
    def __init__(self, filename):
        self.db = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="rental_company"
        )

        self.cs = self.db.cursor()

        with open(filename, 'r') as file:
            self.columns = []
            vals = []
            self.sql = file.readline()
            for line in file.read().splitlines():
                if line == "-":
                    self.columns.append(vals)
                    vals = []
                else:
                    vals.append(line)
            self.columns.append(vals)

    def generate(self, n):
        with open("test.txt", 'w') as file:
            tuples = []
            for i in range(n):
                curr = []
                for j in range(len(self.columns)):
                    column = self.columns[j]
                    if column[0] == "Integer":
                        x = random.randint(10 ** (int(column[1]) - 1), (10 ** int(column[1])) - 1)
                        while x in [tup[j] for tup in tuples]:
                            x = random.randint(10 ** (int(column[1]) - 1), (10 ** int(column[1])) - 1)
                    elif column[0] == "Decimal":
                        print("FUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCK")
                    else:
                        x = random.choice(column)
                    curr.append(x)
                tuples.append(tuple(curr))
            
            print(tuples)

            self.cs.executemany(self.sql, tuples)

            self.db.commit()

            print(self.cs.rowcount, "were inserted.")
        
if __name__ == "__main__":
    builder = Script(argv[1])
    builder.generate(100)