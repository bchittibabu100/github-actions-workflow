import sys
import os
sys.path.append('/home/bogner/prs_eob_maker/')
from mcds_eob_maker import create_builder

CONFIG_FILE = '/home/bogner/hscsn/config.ini'


def build_plain_eob(one_xml, auxFiles=None, fname="test", save=False):
    
    # Document System will pass in Pay Date as "Overlay Date" when calling eob_maker_runner.
    # When ran locally - it will be None - and `create_builder` will set it to the current date.
    payment_date = globals().get('overlay_date', None)

    builder = create_builder(CONFIG_FILE, payment_date=payment_date)

    return builder(one_xml, auxFiles=auxFiles, fname=fname, save=save)

if __name__ == "__main__":
    from glob import glob
    if len(sys.argv) > 1:
        # When in the debugger, we need globbing to get wildcards.
        # When in the shell, the shell expands the wildcards into
        # multiple arguments.  Doing this loop will cover all cases.
        for globTarg in sys.argv[1:]:
            files = glob(os.path.expandvars(os.path.expanduser(globTarg)))
            for path in files:
                with open(path, 'rb') as xml_handle:
                    xml = xml_handle.read()
                    fName = os.path.splitext(os.path.basename(path))[0]
                    pdfPath = os.path.dirname(path)
                    pdffile = os.path.join(pdfPath, fName) + ".pdf"
                    raw = build_plain_eob(xml, fname=pdffile, save=False)
                    with open(pdffile, "wb") as f:
                        f.write(raw)
                    print("Generated %s" % pdffile)
    else:
        print("No file argument")
    print("Finished")
