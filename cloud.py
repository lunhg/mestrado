#!/usr/bin/python

# Algumas bibliotecas principais
from wordcloud import WordCloud     # Nuvem de palavras
import nltk                         # Processamento de linguagem natural
import matplotlib.pyplot as plt     # Desenha foto
from subprocess import Popen, PIPE  # Acessa um o conversor de pdf
from optparse import OptionParser   # Cria um programa

# Bibliotecas basicas
from os import path
import math

# PROGRAMA PRINCIPAL
def linha_de_comando(nome, versao, descricao): 
    parser = OptionParser(usage='usage: %prog [OPTIONS, [ARGS]]', version='%s %s' % (nome, versao), description=descricao)
    parser.add_option("-i","--input",action=None,help="arquivo pdf de entrada",dest="input",default=False)
    parser.add_option("-q","--qualidades",action=None,help="classificacao por qualidades (0..n-1)",dest="qualidades",default=False)
    parser.add_option("-f","--fotinha",action="store_true", help="arquivo de saida da foto",dest="fotinha",default=False),
    parser.add_option("-p","--paginas",action=None,help="paginas processadas",dest="paginas",default=False)
    parser.add_option("-c","--codec",action=None,help="tipo de codificacao do texto",dest="codec",default=False)
    parser.add_option("-t","--latex-table",action=None,help="converte a nuvem para uma tabela tex",dest="tex",default=False)

    # Life cycle
    (options, args) = parser.parse_args()
    pages = []
    if options.paginas:
        split =  options.paginas.split("..") 
        a = [ str(s) for s in range(int(split[0]), int(split[1])) ]
        pages = ",".join(a)
    else:
        pages = [1,2]
    text = convert_pdf_to_txt(options.input,pages,options.codec)
    
    # Nuvem
    nuvem = WordCloud().generate(text)
    if options.fotinha:
        gera_figura(nuvem)
        
    # Taggins
    tagging = nltk.pos_tag(nltk.word_tokenize(text))
    qualidades = gera_grupos_qualitativos(nuvem, tagging, int(options.qualidades) or 10)
    if(options.tex):
        f = open("./livecoding-table.tex", "w+")
        f.write(table(tagging, options.qualidades, options.tex, "tab:livecoding").decode(options.codec))
        f.close()
        print "=> writed ./livecoding-table.tex"
    
#http://davidmburke.com/2014/02/04/python-convert-documents-doc-docx-odt-pdf-to-plain-text-without-libreoffice/
#http://stackoverflow.com/questions/5725278/python-help-using-pdfminer-as-a-library
def convert_pdf_to_txt(p, pages, codec):
    name = p.split(".pdf")[0].split("/")[-1]
    _path = path.abspath("%s.txt") % name
    print "converting %s to %s  ... " % (p,_path)
    command = "pdf2txt.py -o %s -p %s -c %s %s" % (_path, pages, codec, p)
    print command
    #https://stackoverflow.com/questions/24340877/why-does-this-bash-call-from-python-not-work
    result = Popen(command, stdout=PIPE, shell=isinstance(command, str))
    print result.communicate()
    print "... checking ascii characters"
    f = open(_path)
    s = ""
    for i, line in enumerate(f.readlines()):
        l = line.decode(codec)
        s += l

    return s
    
# gera figura a partir da nuvem
def gera_figura(nuvem):
    plt.figure()
    plt.imshow(nuvem)
    plt.axis("off")
    plt.show()
    
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
def criaGrupos(nuvem, tagging, n, groups={}):
    for i, t in enumerate(nuvem.words_):
        freq = t[1]
        word = t[0].title()
        index = int(math.floor(freq*n))
        if freq >= index/float(n) and freq < (index+1)/float(n):
            if not str(index) in groups.keys():
                groups.__setitem__(str(index), {})
                
            for tag in tagging:
                t = tag[0].title()
                if word == t:
                    if not str(tag[1]) in groups.__getitem__(str(index)):
                        groups.__getitem__(str(index)).__setitem__(tag[1], [])

                    if not word in groups.__getitem__(str(index)).__getitem__(tag[1]):
                        groups.__getitem__(str(index)).__getitem__(tag[1]).append(word)
    
    return groups

def gera_grupos_qualitativos(nuvem, tagging, n):
    print "=>Most used words<="
    groups = criaGrupos(nuvem, tagging, n)
    print groups
    return groups

def table(groups, size, caption, label):
    string =  """\\begin{table}
\\centering
\\caption{%s}
\\label{%s}
\\small
\\begin{tabular}{""" % (caption, label)
    string = string + "%s" % "".join([" | p{1.3cm}" for i in range(int(size))])
    string = string + """ | }
\\hline
\\hline
"""
    string = string + "\\tiny \\textbf{Quality/Function} %s \\\\" %  "".join([" & \\textbf{%s}" % i for i in range(int(size))])
    string = string + """
\\hline 
\\hline"""
    for k,v in groups:
        string = string + """

\\tiny \\textbf{%s}
""" % k
        for _v in v:
            string = string + """
& %s
""" % _v
            string = string + """\\\\
\\hline

"""
    print string
    return string
    
linha_de_comando("claudio", "0.0.1", "Script python para gerar nuvem de arquivos pdf")
