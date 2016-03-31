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
    parser = OptionParser(usage='usage: %prog [OPTIONS, [ARGS]]', 
                          version='%s %s' % (nome, versao), 
                          description=descricao)
    # Cria opcoes
    parser.add_option("-e","--entrada",
                      action=None,
                      help="arquivo pdf de entrada",
                      dest="input",default=False)
    parser.add_option("-q","--qualidades",
                      action=None,
                      help="classificacao por qualidades (0..n-1)",
                      dest="qualidades",
                      default=False)
    parser.add_option("-f","--foto",
                      action="store_true", 
                      help="arquivo de saida da foto",
                      dest="fotinha",
                      default=False),
    parser.add_option("-p","--paginas",
                      action=None,
                      help="paginas processadas",
                      dest="paginas",
                      default=False)
    parser.add_option("-c","--codec",
                      action=None,
                      help="tipo de codificacao do texto",
                      dest="codec",
                      default=False)
    parser.add_option("-t","--table",
                      action=None,
                      help="converte a nuvem para uma tabela: \n\t-tex (suportado)\n\t-mardown (planejado)",
                      dest="table",
                      default=False)

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
    print "\n\nA gerar nuvem ..."
    nuvem = WordCloud().generate(text)
    print "=> Feito"
    if options.fotinha:
        gera_figura(nuvem)
    
    #if options.table:
    # Taggins
    print "\n\nA classificar e organizar palavras em uma tabela"
    tagging = nltk.pos_tag(nltk.word_tokenize(text))
    qualidades = gera_grupos_qualitativos(nuvem, tagging, int(options.qualidades) or 10)
    nome = options.input.split(".tex")[0]
    f = open("%s.tex" % options.table, "w+")

    #    if options.table is "tex":
    tabela_tex = table(qualidades, options.qualidades, options.table, "tab:gen").decode(options.codec)
    f.write(tabela_tex)
    f.close()
    print "=> Feito: %s.tex" % options.table
    
#http://davidmburke.com/2014/02/04/python-convert-documents-doc-docx-odt-pdf-to-plain-text-without-libreoffice/
#http://stackoverflow.com/questions/5725278/python-help-using-pdfminer-as-a-library
def convert_pdf_to_txt(p, pages, codec):
    name = p.split(".pdf")[0].split("/")[-1]
    _path = path.abspath("%s.txt") % name
    print "A converter %s para %s  ... \n\n" % (p,_path)
    command = "=> pdf2txt.py -o %s -p %s -c %s %s" % (_path, pages, codec, p)
    print command
    #https://stackoverflow.com/questions/24340877/why-does-this-bash-call-from-python-not-work
    result = Popen(command, stdout=PIPE, shell=isinstance(command, str))
    #print result.communicate()
    print "=> ... checking ascii characters"
    f = open(_path)
    s = ""
    for i, line in enumerate(f.readlines()):
        l = line.decode(codec)
        s += l

    print "=> Feito"
    return s
    
# gera figura a partir da nuvem
def gera_figura(nuvem):
    print "A gerar uma nuvem de palavras..."
    plt.figure()
    plt.imshow(nuvem)
    plt.axis("off")
    print "=> Pronto"
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
    # primeiro crie uma tabela das funcoes:
    for tag in tagging:
        if not str(tag[1]) in groups:
            groups.__setitem__(tag[1], {})
        
        for t in nuvem.words_:
            freq = t[1]
            index = int(math.floor(freq*n))
            if not str(index) in groups.__getitem__(tag[1]):
                groups.__getitem__(tag[1]).__setitem__(str(index), [])

            word = t[0].title()
            t = tag[0].title()
            if word == t:
                if not word in groups.__getitem__(tag[1]).__getitem__(str(index)):
                    groups.__getitem__(tag[1]).__getitem__(str(index)).append(word)

        for i in range(n):
            if not str(i) in groups.__getitem__(tag[1]):
                groups.__getitem__(tag[1]).__setitem__(str(i), [])
                
    return groups

def gera_grupos_qualitativos(nuvem, tagging, n):
    return criaGrupos(nuvem, tagging, n)

def table(groups, size, caption, label):
    print "=> creating table for %s" % caption
    print groups
    string =  """\\begin{table}
\\centering
\\caption{%s}
\\label{%s}
\\small
\\begin{tabular}{""" % (caption, label)
    string = string + "%s" % "".join([" | p{1cm}" for i in range(int(size)+2)])
    string = string + """ |}
\\hline
\\hline
"""
    # Cabecalho geral
    string = string+ "\\tiny \\textbf{Qualidade/Funcao}\n"
    for i in range(int(size)):
        if i is not int(size)-1:
            string = string + " & \\textbf{%s}\n" % i
        else:
            string = string + " & \\textbf{%s} \\\\ \n" % i
    string = string + "\\hline\n\\hline\n"

    # conteudo again:
    for k, v in groups.iteritems():
        string = string + "\\tiny \\textbf{%s}\n" % k 
        a = range(int(size)+1)
        for i in a:
            string = string + " & \\tiny"
            if len(v[str(i)]) is 0:
                string = string + " -- "
            else:
                string = string + " %s " % ", ".join(v[str(i)])
    
            if i is len(a) :
                string = string + " \\\\ \n"
        string = string + "\\hline\n"
            
    string = string +  """
\\hline
\\end{tabular}
\\end{table}
"""
    print string
    return string
    
linha_de_comando("claudio", "0.0.1", "Script python para gerar nuvem de arquivos pdf")
