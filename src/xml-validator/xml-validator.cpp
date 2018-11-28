#include <xmlwrapp/xmlwrapp.h>

#include <iostream>

using namespace std;

int main() {
  xml::document sch_doc = xml::tree_parser("../extra/test.xsd").get_document();
  xml::schema sch(sch_doc);

  xml::document doc = xml::tree_parser("../extra/test.xml").get_document();

  cout << (sch.validate(doc) ? "valid" : "invalid") << endl;
}
