from os import path
from wordcloud import WordCloud
import math
import nltk
import matplotlib.pyplot as plt

# Abra o arquivo em modo de leitura
t = open("iclc2015.txt", "r").read()
wc = WordCloud().generate(t)
plt.figure()
plt.imshow(wc)
plt.axis("off")
plt.show()

_groups = [[] for i in range(10)]

for i, t in enumerate(wc.words_):
    freq = t[1]
    word = t[0]
    index = int(math.floor(freq*10))
    if freq >= index/10.0 and freq < (index+1)/10.0:
        _groups[index-1].append(word)
        ###
# CC: conjunction, coordinating
# CD: numeral, cardinal
# DT: determiner
# EX: existential there
# FW: foreign word
# IN: preposition or conjunction, subordinating
# JJ: adjective or numeral, ordinal
# JJR: adjective, comparative
# JJS: adjective, superlative
# LS: list item marker
# MD: modal auxiliary
# NN: noun, common, singular or mass
# NNP: noun, proper, singular
# NNPS: noun, proper, plural
# NNS: noun, common, plural
# PDT: pre-determiner
# POS: genitive marker
# PRP: pronoun, personal
# PRP$: pronoun, possessive
# RB: adverb
# RBR: adverb, comparative
# RBS: adverb, superlative
# RP: particle
# SYM: symbol
# UH: interjection
# VB: verb, base form
# VBD: verb, past tense
# VBG: verb, present participle or gerund
# VBN: verb, past participle
# VBP: verb, present tense, not 3rd person singular
# VBZ: verb, present tense, 3rd person singular
# WDT: WH-determiner
# WP: WH-pronoun
# WP$: WH-pronoun, possessive
# WRB: Wh-adverb
###
groups = [nltk.pos_tag(e) for e in _groups]

def table(groups, caption,label):
    n = len(group)
    string =  """\begin{table}[]
    \centering
    \caption{%s}
    \label{%label}
    \begin{tabular}{""" % (caption, label)
    string = "%s%s" %(string, ["l" for i in range(n)].join(""))
    string = "}\n"
    string = "%sQuality/Function%s \\\\\n" % (string, ["& %s" % i for i in range(n)].join(""))

def organiza(groups):
    o = {}
    for group in groups:
        for el in group:
            if not el[1] in o.keys():
                o[el[1]] = []
                for g in _groups:
                    o[el[1]].append([])
            for g in _groups:
                for _g in g:
                    if _g == el[1]:
                        o[el[1]][groups.indexOf(g)] = _g
    return o

print organiza(groups)
