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
        tuples = []
        for i in range(n):
            curr = []
            for j in range(len(self.columns)):
                column = self.columns[j]
                if column[0] == "Unique Integer":
                    x = random.randint(int(column[1]), int(column[2]))
                    while x in [tup[j] for tup in tuples]:
                        x = random.randint(int(column[1]), int(column[2]))
                elif column[0] == "Integer":
                    x = random.randint(int(column[1]), int(column[2]))
                elif column[0] == "Decimal":
                    x = float(decimal.Decimal(random.randrange(int(column[1]), int(column[2]))/100))
                elif column[0] == "City State":
                    city_state = "City State"
                    while city_state == "City State":
                        city_state = random.choice(column)
                    column.remove(city_state)
                    city = city_state[:city_state.index(",") - 1]
                    x = city_state[city_state.index(",") + 1:]
                    curr.append(city)
                else:
                    x = random.choice(column)
                curr.append(x)
            tuples.append(tuple(curr))
        
        for tup in tuples:
            print(tup)

        self.cs.executemany(self.sql, tuples)

        self.db.commit()

        print(self.cs.rowcount, "were inserted.")

if __name__ == "__main__":
    builder = Script(argv[1])
    builder.generate(int(argv[2]))