To determine which modules are public Python modules and which are not, you can divide them into two categories:

1. Public Python Modules
These are standard library modules or widely-used third-party modules available on platforms like PyPI.


2. Non-Public Modules
These include:

Project-specific modules (created internally for your project).

Custom modules/files in your project directory.




Analysis of the List

Below is the categorization:

Public Python Modules

These are standard or widely available third-party modules:

argparse

collections

contextlib

configparser

csv

datetime

decimal

distutils.util

email

faker

glob

io

itertools

json

logging

lxml

math

mock

os

pathlib

paramiko

pickle

pyodbc

PyPDF2

re

reportlab

setuptools

shutil

socket

sys

typing

unidecode

unittest

zipfile


Non-Public Modules

These are custom modules, project-specific files, or not widely recognized:

AASJurisdictionalLanguage

AMFParser_py2, AMFParser_py3

BaseFixedLengthParser

BaseNumberedCanvas

BatchFile

BoardingImportFile

CPTParser

CCMParserFactory

CCMParser

CheckNumberIncrementer

CustomMandatoryLanguage

CustomPageNumCanvas

DbCheckNumberIncrementer

FXGParser

EHIParser

EIGNumberedCanvas

GetConfiguration

LWCCNumberedCanvas

MOONumberedCanvas

MTMParser_py2, MTMParser_py3

NumberedCanvas

NATParser

OcfEobController, OcfEobMakerProvider, OcfEobStyleSheet

PaymentPdfCollector

PepController

ProcessPickledObjects

TemplateBuilderController

TemplateCompilerController

Utilities

VPDSGenericParser

WPEParser

ZipDualSpecParser

ZipFixedLengthParser_py2, ZipFixedLengthParser_py3

ZipPEPParser

archiver

converter

db_check_number_incrementer

eob

eob_makers

etree_util

include

pep_main_process

prs_eob_maker

process_pickled_objects

src


Method to Verify Public Modules

You can verify if a module is part of the Python standard library or a third-party module by checking:

1. Python's official documentation.


2. Searching on PyPI (pypi.org) for third-party modules.


3. Use the following command in Python for installed modules:

help('modules')



Would you like detailed checks for specific modules or any further assistance?

