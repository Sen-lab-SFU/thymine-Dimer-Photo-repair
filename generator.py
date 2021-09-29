import gzip
import sys
import time
import xlsxwriter
from collections import Counter

import pandas as pd

#print("Runnning")
def printAllKLength(set, k):
    n = len(set)
    printAllKLengthRec(set, "", n, k)


# The main recursive method
# to print all possible
# strings of length k
def printAllKLengthRec(set, prefix, n, k):
    # Base case: k is 0,
    # print prefix
    if (k == 0):
        values.append(prefix)
        return

    # One by one add all characters
    # from set and recursively
    # call for k equals to k-1    for i in range(n):
    for i in range(n):
        # Next character of input added
        newPrefix = prefix + set[i]

        # k is decreased, because
        # we have added a new character
        printAllKLengthRec(set, newPrefix, n, k - 1)


# TACGCGTGTATACATACACACACGTATGTAT
# GTTGTGCGTGTATGTATGTGTATACGTACG

# GAAGAGCACACGTCTGAACTCCAGTCACCGG
#

values = []
printAllKLength(['A','C','T','G'], 1)
printAllKLength(['A','C','T','G'], 2)
printAllKLength(['A','C','T','G'], 3)
printAllKLength(['A','C','T','G'], 4)
printAllKLength(['A','C','T','G'], 5)
# printAllKLength(['A','C','T','G'], 6)
# printAllKLength(['A','C','T','G'], 7)
# printAllKLength(['A','C','T','G'], 8)
# printAllKLength(['A','C','T','G'], 9)
# printAllKLength(['A','C','T','G'], 10)

def n_search(seq, n, results_n):
    all_results = []
    for i in range(0,len(seq)+1-n):
        result = ""
        for j in range(0,n):
            result += seq.decode("utf-8")[i+j]
        results_n[i][result] += 1

def middle_search(left_seq, right_seq, n, results):
    if len(left_seq) != 5 or len(right_seq) != 5:
        return
    result = ""
    for i in range(0, n):
        result += left_seq.decode("utf-8")[len(left_seq)-i-1]
    for i in range(0, n):
        result += right_seq.decode("utf-8")[i]
    results[0][result] += 1

#NNNNNTTNNNNN
#
#print(len(values))
#
#df = pd.Dataframe(columns=values)
indexes = ["0","1","2","3","4"]
indexesDict = dict.fromkeys(indexes, Counter)
sequencesDict = Counter()

# sequence_counts = dict.fromkeys(values, 0)

#TACGCGTGTATACATACACACACGTATGTATATGTACACGCACGTGTATACNNNNNTTNNNNNGCACACATATGTGTACACACACGTACGTATACACATAC ATACACGCACATG

#Sequence first run: sequence = "TACACGCACGTGTATAC" #TGTACACATATGTGTGC

i = 2
class results_data:
    #Build arrays
    def __init__(self):
        self.n_1_left = [Counter(), Counter(), Counter(), Counter(), Counter()]
        self.n_2_left = [Counter(), Counter(), Counter(), Counter()]
        self.n_3_left = [Counter(), Counter(), Counter()]
        self.n_4_left = [Counter(), Counter()]
        self.n_5_left = [Counter()]

        self.n_1_right = [Counter(), Counter(), Counter(), Counter(), Counter()]
        self.n_2_right = [Counter(), Counter(), Counter(), Counter()]
        self.n_3_right = [Counter(), Counter(), Counter()]
        self.n_4_right = [Counter(), Counter()]
        self.n_5_right = [Counter()]

        self.n_1_middle = [Counter()]
        self.n_2_middle = [Counter()]
        self.n_3_middle = [Counter()]
        self.n_4_middle = [Counter()]
        self.n_5_middle = [Counter()]

    #Save all of the different sequences to respective files
    def save(self, file, sequence_str):
        writer = pd.ExcelWriter(file[:-9]  + sequence_str + '.xlsx', engine='xlsxwriter')
        print("Saving: " + file[:-9] + sequence_str + '.xlsx')
        #writer = pd.ExcelWriter('output.xlsx', engine='xlsxwriter')
        #print("Saving: " + file[:-9] + sequence_str + '.xlsx')
        pd.DataFrame.from_dict(self.n_1_left).sort_index(axis=1).to_excel(writer, sheet_name='n_1_left'+sequence_str)
        pd.DataFrame.from_dict(self.n_2_left).sort_index(axis=1).to_excel(writer, sheet_name='n_2_left')
        pd.DataFrame.from_dict(self.n_3_left).sort_index(axis=1).to_excel(writer, sheet_name='n_3_left')
        pd.DataFrame.from_dict(self.n_4_left).sort_index(axis=1).to_excel(writer, sheet_name='n_4_left')
        pd.DataFrame.from_dict(self.n_5_left).sort_index(axis=1).to_excel(writer, sheet_name='n_5_left')

        pd.DataFrame.from_dict(self.n_1_middle).sort_index(axis=1).to_excel(writer, sheet_name='n_1_middle')
        pd.DataFrame.from_dict(self.n_2_middle).sort_index(axis=1).to_excel(writer, sheet_name='n_2_middle')
        # Factorial means that the excel 32,000 column limit is exceed at n = 4. This is fine as the significance at that size would be low

        # pd.DataFrame.from_dict(results_n_3_middle).sort_index(axis=1).to_excel(writer, sheet_name='n_3_middle')
        # pd.DataFrame.from_dict(results_n_4_middle).sort_index(axis=1).to_csv("test.csv")
        # pd.DataFrame.from_dict(results_n_4_middle).sort_index(axis=1).to_excel(writer, sheet_name='n_4_middle')
        # pd.DataFrame.from_dict(results_n_5_middle).sort_index(axis=1).to_excel(writer, sheet_name='n_5_middle')

        pd.DataFrame.from_dict(self.n_1_right).sort_index(axis=1).to_excel(writer, sheet_name='n_1_right')
        pd.DataFrame.from_dict(self.n_2_right).sort_index(axis=1).to_excel(writer, sheet_name='n_2_right')
        pd.DataFrame.from_dict(self.n_3_right).sort_index(axis=1).to_excel(writer, sheet_name='n_3_right')
        pd.DataFrame.from_dict(self.n_4_right).sort_index(axis=1).to_excel(writer, sheet_name='n_4_right')
        pd.DataFrame.from_dict(self.n_5_right).sort_index(axis=1).to_excel(writer, sheet_name='n_5_right')
        writer.save()

results_data_tt = results_data()
results_data_tc = results_data()
results_data_ct = results_data()
results_data_cc = results_data()

from os import listdir
from os.path import isfile, join
#First run files = [f for f in listdir('data/source/') if isfile(join('data/source/', f))]
#Second run
print("Runnning")

#Sequence first run: sequence = "TACACGCACGTGTATAC" #TGTACACATATGTGTGC
#sequence = "TACACGCACGTGTATAC"
#directory = "data/source/"

#Second run
sequence = "CGCACGTGTATAC"
directory = "data/source_second_run/"

files = [f for f in listdir(directory) if isfile(join(directory, f))]
#print(onlyfiles)

writer = pd.ExcelWriter('output.xlsx', engine='xlsxwriter')
writer.save()

#Iterate over each file in the directory
for file in files:
    print("Processing: "+file)
    length = 0
    start_time = time.time()
    with gzip.open(directory+file, 'rb') as f:
        for line in f:
            if i == 3:
                index = str(line).find(sequence) + 11
                # Add TC CC CT
                results = results_data_tt
                if line[index:][5:][:2] == b'TT':
                    results = results_data_tt
                if line[index:][5:][:2] == b'TC':
                    results = results_data_tc
                if line[index:][5:][:2] == b'CT':
                    results = results_data_ct
                if line[index:][5:][:2] == b'CC':
                    results = results_data_cc
                if line[index:][5:][:2] == b'TT' or line[index:][5:][:2] == b'TC' or line[index:][5:][:2] == b'CT' or line[index:][5:][:2] == b'CC':
                    left_side = line[index:][:5]
                    right_side = line[index:][7:][:5]
                    middle_search(left_side, right_side, 1, results.n_1_middle)
                    middle_search(left_side, right_side, 2, results.n_2_middle)
                    middle_search(left_side, right_side, 3, results.n_3_middle)
                    middle_search(left_side, right_side, 4, results.n_4_middle)
                    middle_search(left_side, right_side, 5, results.n_5_middle)

                    n_search(left_side, 1, results.n_1_left)
                    n_search(left_side, 2, results.n_2_left)
                    n_search(left_side, 3, results.n_3_left)
                    n_search(left_side, 4, results.n_4_left)
                    n_search(left_side, 5, results.n_5_left)

                    n_search(right_side, 1, results.n_1_right)
                    n_search(right_side, 2, results.n_2_right)
                    n_search(right_side, 3, results.n_3_right)
                    n_search(right_side, 4, results.n_4_right)
                    n_search(right_side, 5, results.n_5_right)
                i = -1
            i += 1
            length += 1
    print(length)
    print("--- %s seconds ---" % (time.time() - start_time))
    results_data_tt.save(file, 'tt')
    results_data_cc.save(file, 'cc')
    results_data_ct.save(file, 'ct')
    results_data_tc.save(file, 'tc')

