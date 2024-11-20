from mcds_eob_maker import create_builder
from glob import glob
from CPTParser import CPTParser
from mock import patch
from unittest2 import TestCase
from unittest import TestCase
from unittest.mock import patch
from socket import gethostname
from UploadFile import UploadFile
from ssh import Connection
from itertools import islice
from collections import deque
from Utilities import getSystemConfig
from process_pickled_objects import pickle_upload_from datetime import datetime
from configobj import ConfigObj
from Utilities import safe_list_get, notification
from datetime import datetime
from process_pickled_objects import pickle_upload_files
from Utilities import getSystemConfig, notification, safe_list_get
from reportlab.lib.pagesizes import letter
from reportlab.lib import colors
from reportlab.lib import styles
from reportlab.lib import enums
from reportlab.lib.units import mm, cm, inch
from io import BytesIO
from lxml import objectify
from reportlab.platypus import (Image, Paragraph, Table,
                                SimpleDocTemplate, TableStyle,
                                KeepTogether, PageBreak)
from reportlab.lib.enums import TA_LEFT, TA_CENTER
from collections import namedtuple
from lxml import etree
from mock import MagicMock, patch, call, mock_open
from MTMParser_py2 import HashDataIterator, MTMParser, main
from unittest.mock import MagicMock, patch, call, mock_open
from MTMParser_py3 import HashDataIterator, MTMParser, main
from ZipDualSpecParser import ZipDualSpecParser
from Utilities import safe_list_get
from argparse import ArgumentParser
from pathlib import Path
from bust_up_otb import bust_up_otb
from lockfile import LockFile
from typing import Union
from collections import defaultdict
from GetConfiguration import GetConfig
from check_number_incrementer import CheckNumberIncrementer
from argparse import ArgumentParser, Namespace
from db_check_number_incrementer import Database
from Utilities import notification
from eob import OcfEobController, OcfEobMakerProvider, OcfEobStyleSheet
from eob.eob_makers import OcfEebFactory
from db_check_number_incrementer import DbCheckNumberIncrementer
from file_835_pre_parser import File835PreParser
from converter.converter import Converter
from math import floor
from reportlab.lib.styles import StyleSheet1, ParagraphStyle
from reportlab.lib.enums import TA_JUSTIFY, TA_CENTER, TA_LEFT, TA_RIGHT
from reportlab.lib.units import mm, inch
from reportlab.lib.units import mm
from reportlab.pdfgen import canvas
from .ocf_eob_controller import OcfEobController
from .eob_makers.ocf_eob_maker_provider import OcfEobMakerProvider
from .ocf_eob_helper_modules.ocf_eob_style_sheet import OcfEobStyleSheet
from reportlab.platypus import (SimpleDocTemplate, Paragraph, Table, KeepTogether)
from ..ocf_eob_controller import OcfEobController
from ..ocf_eob_controller import OcfAdjustmentCode
from ..ocf_eob_helper_modules.ocf_eob_style_sheet import OcfEobStyleSheet
from ..ocf_eob_helper_modules.page_num_canvas import CustomPageNumCanvas
from reportlab.platypus import PageBreak, Paragraph, Table, Spacer, Image, KeepTogether
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.units import inch, mm
from reportlab.lib.enums import TA_RIGHT
from eob.eob_makers.staple_appeals_language import staple_appeals_language
from eob.eob_makers.ocf_base_eob_maker import OcfBaseEobMaker
from eob.ocf_eob_controller import OcfEobController
from PyPDF2 import PdfFileReader, PdfFileWriter
from reportlab.lib.units import inch
from reportlab.platypus import (Image, PageBreak, KeepTogether,
                                Paragraph, SimpleDocTemplate, Table)
from reportlab.platypus.frames import Frame
from reportlab.platypus.tables import TableStyle
from eob.ocf_eob_helper_modules.ocf_eob_helper_functions import col_widths_from_ratios
from PyPDF2 import PdfFileWriter, PdfFileReader
from .ocf_adjustment_code import OcfAdjustmentCode
from .ocf_adjustment import OcfAdjustment
from .ocf_claim_level_adjustment import OcfClaimLevelAdjustment
from .ocf_claim_totals import OcfClaimTotals
from .ocf_claim_line_item import OcfClaimLineItem
from .ocf_claim import OcfClaim
from .ocf_provider_adjustment import OcfProviderAdjustment
from decimal import Decimal
from . import OcfAdjustmentCode
from functools import lru_cache
from typing import List
from eob.ocf_eob_controller.ocf_claim_totals import OcfClaimTotals
from ..ocf_eob_helper_modules.ocf_eob_helper_functions import (get_first,
                                                               get_first_if)
from . import OcfClaimLineItem
from . import OcfClaimLevelAdjustment
from . import OcfAdjustment
from . import OcfClaim
from eob.ocf_eob_controller.member_support_numbers import MemberSupportNumbersLoader
from ..ocf_eob_helper_modules.ocf_eob_helper_functions import (get_first)
from . import OcfAdjustment, OcfAdjustmentCode, OcfClaim, OcfProviderAdjustment
from prs_eob_maker.language import Language
from prs_eob_maker.payment_data_factory import PaymentDataFactory
from configparser import ConfigParser
from configuration import AfldPdfZipPreprocessorConfig
from archiver import Archiver
from input_file_collector import InputFileCollector, InputFileCollectorFactory
from output_file_publisher import OutputZipPublisher, OutputZipPublisherFactory
from zip_processor import ZipProcessor
from get_environment_path import GetEnvironmentPath
from configuration import ArchiveConfig
from dataclasses import dataclass
from connection import ConnectionArgs
from contextlib import contextmanager
from typing import Generator
from typing import Iterator, List, Union
from paramiko import SFTPClient
from configuration import CollectorConfig
from connection import Connection, ConnectionArgs
from configuration import OutputPublisherConfig
from connection import ConnectionArgs, Connection
from zip_processor import OutputZip
from configuration import ZipProcessorConfig
from reportlab.lib.enums import TA_CENTER, TA_LEFT, TA_RIGHT
from reportlab.lib.styles import ParagraphStyle, StyleSheet1
from reportlab.platypus import (Image, Paragraph, SimpleDocTemplate, Spacer, Table)
from etree_util import objectify_string_only
from aas_eob_controller import Eob
from AASJurisdictionalLanguage import jurisdictional_language
from GetConfiguration import GetConfigOrDefault
from collections import namedtuple, OrderedDict
from reportlab.platypus import Image, SimpleDocTemplate, Paragraph, Spacer, Table, FrameBreak
from reportlab.platypus.flowables import CondPageBreak
from reportlab.lib.pagesizes import letter, landscape
from EIGNumberedCanvas import NumberedCanvas
from xml.sax.saxutils import escape
from GetConfiguration import
import datetime
from email.mime.text import MIMEText
from HTMLParser import HTMLParser
from optparse import OptionParser, SUPPRESS_HELP
from re import sub
from lxml import etree, objectify
from Utilities import getSystemConfig, notification
from BoardingImportFile import BoardingImportFile
from unidecode import unidecode
from eob.cpi_eob_controller import Eob, write_file, is_py2
from eob.cpi_custom_eob_maker import CPICustomEobMaker
from eob.default_eob_maker import CPIDefaultEobMaker
from reportlab.lib.pagesizes import landscape, letter
from reportlab.platypus import KeepTogether, Paragraph, SimpleDocTemplate, Spacer, Table
from eob.cpi_eob_controller import (
    LineItem,
    get_be_logo,
    col_widths_from_ratios,
    format_decimal,
    rotate_memory_buffer_pdf,
)
from reportlab.platypus import Image
from reportlab.platypus import (KeepTogether, PageBreak, Paragraph,
                                SimpleDocTemplate, Spacer, Table)
import PyPDF2
from reportlab.platypus import (SimpleDocTemplate, Image)
from eob.ceic_eob_types import CeicEmptyEob
from eob.ceic_eob_types import CeicFatalAndPermTotalAndPermPartialEob
from eob.ceic_eob_types import CeicTemporaryTotalEob
from eob.ceic_eob_types import CeicTemporaryPartialEob
from eob.ceic_eob_types import CeicCutOffEob
from eob.ceic_eob_data_models import Payer, Payee, Payment, Claim, TerminationNotes
from eob.ceic_eob_style_sheet import CeicEobStyleSheet
from eob.xml_funcs import get_text_from_
from reportlab.platypus import Paragraph, Table
from Utilities import coord
from .ceic_eob_data_models import Language
from .xml_funcs import get_text_from_element
from reportlab.lib.units import from reportlab.platypus import Paragraph, Table
from .ceic_eob_base import CeicBaseEob
from .ceic_eob_base import format_date
from reportlab.lib.enums import TA_LEFT, TA_RIGHT
from reportlab.platypus import (Image,  Paragraph, SimpleDocTemplate, Spacer, Table, PageBreak)
from EHINumberedCanvas import NumberedCanvas, coord
from ehi_eob_controller import Eob
from eob_makers.moo_remit import MOORemitMaker as MOOEOBMaker
from eob_makers.moo_provider_eob import MOOProviderEOBMaker as MOOEOBMaker
from eob_makers.moo_member_eop import MOOMemberEOPMaker as MOOEOBMaker
from BaseNumberedCanvas import NumberedCanvas as BaseNumberedCanvas
from reportlab.platypus import BaseDocTemplate, PageTemplate
from reportlab.pdfgen.canvas import Canvas
from itertools import chain, groupby
from reportlab.platypus import Image, Indenter, PageBreak, Paragraph, Spacer, Table, KeepTogether
from .MOONumberedCanvas import NumberedCanvas
from .MarginSizeDocTemplate import MarginSizeDocTemplate
from .base import MOOEOBMaker, format_dollar
import datetime as dt
from reportlab.platypus import Indenter, PageBreak, Paragraph, Spacer, Table
from Utilities import get_clean_list
from reportlab.platypus import Table
from prs_eob_maker import (
    PrsEobController, PrsEobMaker, Language, StandardSurpriseBillingText,
    PaymentDataFactory, get_integer_config_or_default, PRSPaymentData)
from prs_eob_maker.language import CustomContractLanguage, CustomMandatoryLanguage
from zip_csv_parser import ZipCSVParser
from include.validators import Validators, ValidationResult
from csv_controller import PaymentPdfCollector
import logging.config
import os
import sys
from ZipPEPParser import ZipPEPParser
from reportlab.platypus import (Flowable, SimpleDocTemplate, Paragraph, Table, KeepTogether, Image, PageBreak)
from reportlab.platypus.flowables import Spacer
from Utilities import notification, coord
from wpe_eob_helper_modules.wpe_eob_controller import BE, EOB
from wpe_eob_helper_modules.wpe_eob_maker_provider import WpeEobMakerProvider
from wpe_eob_helper_modules.wpe_eob_style_sheet import WpeEobStyleSheet
from unittest.mock import MagicMock, call, patch
from mock import MagicMock, call, patch
from WPEParser import WPEParser, main
from config_data_unit_testing import (
    pep_config, parser_config_dict, config_dict, dual_spec_config_dict, otb_dict
from .wpe_eob_data_models import PaymentInfo, Claim
from .wpe_eob_helper_functions import try_get_records, numeric_string_sort_key
from .wpe_eob_helper_functions import format_date, get_value, get_date
from reportlab.platypus import (Paragraph, Table, KeepTogether, PageBreak, Spacer)
from AMFParser_py2 import AMFParser, main
from AMFParser_py3 import AMFParser, main
from NoRetry import NoRetry
sys.path.append(""/home/bogner/fixed_length_process"")
from BaseFixedLengthParser import BaseFixedLengthParser
from Utilities import unzipPaymentFile, safe_list_get
from ZipFixedLengthParser_py2 import ZipFixedLengthParser, main
from ZipFixedLengthParser_py3 import ZipFixedLengthParser, main
from VPDSGenericParser import VPDSGenericParser
from Utilities import notification, safe_list_get
from reportlab.platypus import (Image, SimpleDocTemplate, Spacer,
                                Paragraph, Table, FrameBreak)
from reportlab.platypus.flowables import (CondPageBreak, PageBreak)
from collections import OrderedDict
from PDFTools import staple_pdf_list
from GetConfiguration import GetConfig, GetConfigOrDefault
from pdf_file_helper import PdfFileHelper, BadPdfException
from mock import MagicMock, patch, call, mock_open, ANY
from AMFParser_py2 import AMFParser
from ZipFixedLengthParser_py2 import ZipFixedLengthParser
from unittest.mock import MagicMock, patch, call, mock_open, ANY
from AMFParser_py3 import AMFParser
from ZipFixedLengthParser_py3 import ZipFixedLengthParser
from Utilities import normalize_to_printable_ascii
from pep_controller import DELIMITER as separator
from unittest.mock import MagicMock, patch, call
open_builtin_path = ""builtins.open"
from FXGParser import FXGParser, FXGReconciledFileException, main
from reportlab.platypus import (Flowable, PTOContainer, Paragraph,
                                Spacer, KeepTogether, FrameBreak, PageBreak)
from reportlab.platypus.flowables import (_listWrapOn, _flowableSublist,
                                          UseUpSpace, copy)
from reportlab.rl_config import _FUZZ
from os import path
from etree_util import makeElement
from pep_main_process import main as pep_main
from dualspec_virtual_process import main as dual_spec_main
from ccm_common_methods import is_py2
from mock import MagicMock, patch, call
from ccm_main_process import run_process, main
from ccm_eob_xml_generator import getPayeeName, getCheckYMD, createEOBXML
from CCMParserFactory import CCMParserFactory, main
from sendEmail import SendEmailWithDefaultConfig
from datetime import date, timedelta, datetime
from report_utils import ConditionalInsertOnNextPage
from reportlab.platypus.flowables import (CondPageBreak, PageBreak  )
from NumberedCanvas import NumberedCanvas
from Utilities import format_number
from nat_common_methods import is_py2
from magicmock_plus import MagicMockPlus
from NATParser import NATParser, main
from decimal import Decimal, InvalidOperation
from RCBaseParser_py2 import RCBaseParser, main
from RCBaseParser_py3 import RCBaseParser, main
from reportlab.lib.enums import TA_CENTER, TA_JUSTIFY, TA_LEFT, TA_RIGHT
from reportlab.platypus import (Image, KeepTogether, PageBreak, Paragraph,
from LWCCNumberedCanvas import NumberedCanvas, coord
from lwcc_eob_controller import Eob, ReasonCodes, ReasonCode, Appeals, AppealLine, Claim, ClaimInfo, LineItem
from classes.Batch import Batch
from classes.User import User
from getopt import getopt, GetoptError
from pyodbc import ProgrammingError
from BatchFile import BatchFile
import ssh
from Utilities import (notification, getSystemConfig,
                       getDbConn)
from log_helper import load_log_config
from setuptools import find_packages, setup
from src.Settings.settings import Settings
from .template_builder import TemplateBuilderController
from .template_compiler import TemplateCompilerController
from .base_controller import BaseController
from src.CustomExceptions.custom_exceptions import FeatureNotImplementedError
from src.DataModels.specs import DualSpecTemplateSpecs
from src.DataModels.templates import DualSpecTemplate
from src.DataModels.payment_file import ParsedDualSpecPaymentFile
from src.DataGenerators.data_generator import FakeDataGenerator
from src.DataModels.payment_file import DualSpecPaymentFile
from src.DataModels.payment_file import PaymentFile
from src.DataValidators.dual_spec_template_validator import DualSpecTemplateValidator
from src.DataValidators.template_validator import TemplateValidator
from src.DataModels.user_configs import UserConfigs
from .custom_exceptions import DittoTemplateNotFoundError
from .custom_exceptions import WrongFileTypeError
from .custom_exceptions import PdfAttachmentNotFoundError
from .custom_exceptions import DittoInterrupted
from faker import Faker
from src.DataModels.fields import Field
from .words import lorem_isupm
from .phone_area_codes import phone_area_codes
from .provider import facility_names
from .provider import facility_types
from src.DataValidators.helper_funcs import convert_data_to_str
from src.DataValidators.helper_funcs import convert_numeric_str_to_int
from zipfile import ZipFile
from distutils.util import strtobool
from .user_configs import UserConfigs
from .fields import DualSpecRecordField
from openpyxl import Workbook
from openpyxl.styles.colors import Color
from openpyxl.styles.fills import PatternFill
from openpyxl.styles import Font
from src.Interface.interrogating_funcs import verify_path
from src.Controllers.base_controller import BaseController
from src.Interface.interface_text import get_prompts
from src.CustomExceptions.custom_exceptions import RequiredTabNotInTemplateError
from src.CustomExceptions.custom_exceptions import CellValueNotANumber
from .template_validator import TemplateValidator
from .helper_funcs import get_column_alfa_reference
from src.CustomExceptions.custom_exceptions import DittoTemplateNotFoundError
from src.CustomExceptions.custom_exceptions import SpecFileNotFoundError
from src.CustomExceptions.custom_exceptions import WrongFileTypeError
from src.CustomExceptions.custom_exceptions import PdfAttachmentNotFoundError
from src.CustomExceptions.custom_exceptions import DittoInterrupted
from src.CustomExceptions.custom_exceptions import PathProvidedNotFound
from src.CustomExceptions.custom_exceptions import NotAValidResponse
from .interface_text import get_prompts
from .MySettings import *
from .SystemSettings import *
from datetime import datetime, timedelta, date
from src.Settings import SystemSettings as Settings
from unittest.mock import MagicMock
from src.Controllers.builder_and_compiler_mixin import BuilderCompilerControllerMixin
from src.Controllers.ditto_controller import DittoController
from src.Controllers.template_compiler import TemplateCompilerController
from src.Controllers.template_builder import TemplateBuilderController
from src.CustomExceptions.custom_exceptions import *
from src.DataGenerators.data_generator import AddressGenerator
from src.DataGenerators.data_generator import PersonNameGenerator
from importlib.metadata import version, PackageNotFoundError
from importlib.metadata import version as get_version
from .Interface.interface_text import display_banner
from .Interface.interface_text import get_help_text
from .Interface.interrogating_funcs import open_spec_file
from .Interface.interrogating_funcs import open_ditto_template
from .Interface.interrogating_funcs import open_pdf_attachment
from .Interface.interrogating_funcs import verify_path
from .Interface.interrogating_funcs import open_file
from .Controllers.ditto_controller import DittoController
from .CustomExceptions.custom_exceptions import *
from reportlab.lib import colors, utils
from reportlab.platypus import Image, SimpleDocTemplate, Paragraph, Spacer, Table
from DRTNumberedCanvas import NumberedCanvas
from companion_data_injector import inject_companion_data
from classes.PMBMessage.PMBMessage import PMBMessage
from amqplib import client_0_8 as amqp
from HandleMessage import HandleMessage
from subprocess import call
from xml.dom.minidom import parse, parseString
from StringIO import StringIO
from ndb_eob_controller import (BE, EOB, LineItem, ClaimException)

