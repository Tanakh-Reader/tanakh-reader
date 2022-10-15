from lxml import etree

import json
import xmltodict

def run_xpath_for_file(xpath, file):
    tree = etree.parse(file)
    return tree.xpath(xpath)

f = 'macula/01-Gen-001-lowfat.xml'

dic = {}

k = '{http://www.w3.org/XML/1998/namespace}id'
nodes = run_xpath_for_file("//w", f)
x = []
for node in nodes:
    obj = {}
    for attr in node.attrib:
        if attr == k:
            obj['id'] = node.attrib[k][1:]
        else:
            obj[attr] = node.attrib[attr]
    obj['text'] =  ''.join(node.itertext())
    x.append(obj)
dic['GEN 1'] = x


with open("data.json", "w", encoding='utf-8') as json_file:
    json.dump(dic, json_file, ensure_ascii=False)