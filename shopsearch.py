#!/usr/bin/python3
'''
usage:
shopsearch <search terms with spacing between words>
'''


# imports
import os
import sys


# website definitions
def _shopee(word_l):
    return 'https://shopee.sg/search?keyword=' + '%20'.join(word_l) + '&page=0&sortBy=sales'
def _carousell(word_l):
    return 'https://sg.carousell.com/search/' + '%20'.join(word_l) + '?'
def _lazada(word_l):
    return 'https://www.lazada.sg/catalog/?q=' + '+'.join(word_l)
def _qoo10(word_l):
    upperword_l = list(map(lambda x: x.upper(), word_l))
    return 'https://www.qoo10.sg/s/'+'-'.join(upperword_l)+'?keyword='+'+'.join(word_l) + '&keyword_auto_change=    '

def _ezbuy(word_l):
    return 'https://ezbuy.sg/category/?keyWords=' + '%20'.join(word_l)
def _amazon(word_l):
    return 'https://www.amazon.sg/s?k=' + '+'.join(word_l)
def _ebay(word_l):
    return 'https://www.ebay.com.sg/sch/?_nkw={}'.format('+'.join(word_l))

def _element14(word_l):
    return 'https://sg.element14.com/search?st=' + '%20'.join(word_l)
def _mouser(word_l):
    return 'https://www.mouser.sg/Search/Refine?Keyword=' + '+'.join(word_l)
def _gearbest(word_l):
    return 'https://www.gearbest.com/sale/{}/'.format('-'.join(word_l))


_casual_l = [_shopee, _carousell, _lazada, _qoo10]
_lookinghard_l = _casual_l + [_ezbuy, _amazon, _ebay]
_technical_l = _casual_l + [_element14, _mouser, _gearbest]


# main func
def main():
    '''
    example usage:
    python3 shopsearch.py [option] <search words>
    
    options
        -1 : casual shopping websites, this is the default
        -2 : looking abit harder
        -3 : looking for something technical while still trying casual
    '''
    arg1 = sys.argv[1]
    if arg1[0] == '-':          # option stated
        word_l = sys.argv[2:]        
        if arg1[1:] == '1':
            urlf_l = _casual_l
        elif arg1[1:] == '2':
            urlf_l = _lookinghard_l
        elif arg1[1:] == '3':
            urlf_l = _technical_l
        else:
            raise ValueError('invalid option specified')
    else:
        urlf_l = _casual_l
        word_l = sys.argv[1:]        

    # getting rid of special character typos
    for i, word in enumerate(word_l):
        word = ''.join(letter for letter in word if letter.isalnum())
        word_l[i] = word

    # running searches
    os.system('google-chrome --new-window {}'.format(urlf_l[0](word_l))) # first link new win
    for url_f in urlf_l[1:]:
        os.system('google-chrome {}'.format(url_f(word_l)))


# running
if __name__ == '__main__':
    main()
