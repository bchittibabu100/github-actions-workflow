╰─ python3 config_analyzer.py                                                                                                                                           ─╯
Traceback (most recent call last):
  File "/Users/cb/Documents/TPA_Repos/config_analyzer.py", line 48, in <module>
    configs.append(parse_config(file))
  File "/Users/cb/Documents/TPA_Repos/config_analyzer.py", line 11, in parse_config
    for key, value in config.items(section):
  File "/opt/homebrew/Cellar/python@3.12/3.12.3/Frameworks/Python.framework/Versions/3.12/lib/python3.12/configparser.py", line 837, in items
    return [(option, value_getter(option)) for option in orig_keys]
  File "/opt/homebrew/Cellar/python@3.12/3.12.3/Frameworks/Python.framework/Versions/3.12/lib/python3.12/configparser.py", line 833, in <lambda>
    value_getter = lambda option: self._interpolation.before_get(self,
  File "/opt/homebrew/Cellar/python@3.12/3.12.3/Frameworks/Python.framework/Versions/3.12/lib/python3.12/configparser.py", line 367, in before_get
    self._interpolate_some(parser, option, L, value, section, defaults, 1)
  File "/opt/homebrew/Cellar/python@3.12/3.12.3/Frameworks/Python.framework/Versions/3.12/lib/python3.12/configparser.py", line 406, in _interpolate_some
    raise InterpolationMissingOptionError(
configparser.InterpolationMissingOptionError: Bad value substitution: option 'format' in section 'formatter_formatter01' contains an interpolation key 'asctime' which is not a valid option name. Raw value: 'F1 %(asctime)s - %(name)s - %(levelname)s - %(message)s'
