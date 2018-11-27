#include <xercesc/dom/DOM.hpp>
#include <xercesc/parsers/XercesDOMParser.hpp>
#include <xercesc/util/PlatformUtils.hpp>

#include <iostream>

using namespace xercesc;
using namespace std;

int main() {
  XMLPlatformUtils::Initialize();

  XercesDOMParser* parser = new XercesDOMParser();
  parser->setExternalNoNamespaceSchemaLocation("test.xsd");
  parser->setExitOnFirstFatalError(true);
  parser->setValidationConstraintFatal(true);
  parser->setValidationScheme(XercesDOMParser::Val_Auto);
  parser->setDoNamespaces(true);
  parser->setDoSchema(true);

  try {
    parser->parse("test.xml");
  } catch (const DOMException& e) {
     cout << "Exception.." << endl;
  }
}
