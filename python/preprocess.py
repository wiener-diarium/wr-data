import os
import glob
import re
import datetime
import lxml.etree as ET
from acdh_tei_pyutils.tei import TeiReader
from tqdm import tqdm


files = glob.glob("./data/pre-process/1*.xml")
out_dir = "./data/pre-process"
os.makedirs(out_dir, exist_ok=True)

day_names_german = {
    "Monday": "Montag",
    "Tuesday": "Dienstag",
    "Wednesday": "Mittwoch",
    "Thursday": "Donnerstag",
    "Friday": "Freitag",
    "Saturday": "Samstag",
    "Sunday": "Sonntag"
}

month_names_german = {
    "January": "Januar",
    "February": "Februar",
    "March": "März",
    "April": "April",
    "May": "Mai",
    "June": "Juni",
    "July": "Juli",
    "August": "August",
    "September": "September",
    "October": "Oktober",
    "November": "November",
    "December": "Dezember"
}
nsmap = {
    "tei": "http://www.tei-c.org/ns/1.0",
    "xml": "http://www.w3.org/XML/1998/namespace"
}

print(f"upconverting {len(files)} transkribus export TEIs and saving them into {out_dir}")
for x in tqdm(files, total=len(files)):
    doc = TeiReader(x)
    dr_id = doc.any_xpath(".//tei:title[@type='main']/text()")[0].split(" ")[-1]
    date_str = dr_id.split("-")
    doc_date_str = datetime.datetime(
        int(date_str[0]), int(date_str[1]), int(date_str[2])
    )
    if doc_date_str < datetime.datetime(1756, 1, 1):
        continue
    formated_date = doc_date_str.strftime("%A den %d. %B %Y")
    for english_day, german_day in day_names_german.items():
        formated_date = formated_date.replace(english_day, german_day)
    for english_month, german_month in month_names_german.items():
        formated_date = formated_date.replace(english_month, german_month)
    file_name = f"wr_{dr_id}.xml"
    ab = doc.any_xpath("//tei:ab[@type='count-date']")
    num = ""
    ab_str = ""
    if isinstance(ab, list) and len(ab) >= 1:
        try:
            ab_str = " ".join(ab[1].xpath(".//text()")).replace("\n", "").strip()
        except IndexError:
            ab_str = " ".join(ab[0].xpath(".//text()")).replace("\n", "").strip()
        re_num = re.search("Num\\.?\s+\d+\\.?", ab_str)
        try:
            num = re_num.group()
            ab_str = f'{num} {ab_str.replace(num, "")}'.strip()
        except AttributeError:
            try:
                num_dig = re.search("^[0-9]+\\.?", ab_str).group()
                num_str = re.search("Num\\.?", ab_str).group()
                num = f"{num_str} {num_dig}"
                ab_str = f'{num} {ab_str.replace(num_str, "").replace(num_dig, "")}'.strip()
            except AttributeError:
                num = "did not find count-date"
                ab_str = "did not find count-date"
    title = ET.Element("title")
    title.attrib["level"] = "a"
    title.attrib["type"] = "main"
    title.text = f"{' '.join(num.split())} {formated_date}"
    titleStmt = doc.any_xpath("//tei:titleStmt")[0]
    titleStmt.append(title)
    ab = ET.Element("ab")
    ab.attrib["type"] = "count-date-normalized"
    for x in ab_str.split():
        wconf = ET.Element("word_conf")
        wconf.attrib["conf"] = "1.00"
        wconf.text = x
        ab.append(wconf)
    div1 = doc.any_xpath("//tei:body/tei:div")[0]
    div1.append(ab)
    doc.tree_to_file(f"{out_dir}/{file_name}")
