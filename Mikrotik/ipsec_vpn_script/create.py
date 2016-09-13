"""
#!/usr/local/bin/python3
"""
import yaml
import sys

"""
Load the site config file
"""
try:
    config_file = sys.argv[1]
except IndexError:
    print("Must include config file as argument.")
    sys.exit(1)

config = []
with open(config_file, 'r') as stream:
    try:
        config = yaml.load(stream)
    except yaml.YAMLError as exc:
        print(exc)
        sys.exit(1)

"""
Load the script template file
"""
try:
    template = open('template.txt', 'r').read()
except FileNotFoundError:
    print('Template file could not be found.')
    sys.exit(1)

result = template.replace(
    'LINK_NAME', config['link_name']).replace(
    'MAIN_PUB', config['main']['public_ip']).replace(
    'MAIN_NETWORK', config['main']['network_address']).replace(
    'MAIN_GW_INTERFACE', config['main']['gw_interface']).replace(
    'SATELLITE_PUB', config['satellite']['public_ip']).replace(
    'SATELLITE_NETWORK', config['satellite']['network_address']).replace(
    'SATELLITE_GW_INTERFACE', config['satellite']['gw_interface'])

print(result)
