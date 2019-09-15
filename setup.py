#!/usr/bin/python3

from distutils.core import setup

setup(
    name='PPA Extender',
    version='0.1.0',
    author='Mirko Brombin',
    description='Easily manage PPA',
    url='https://github.com/linuxhubit/ppaextender',
    license='GNU GPL3',
    scripts=['com.github.linuxhubit.ppaextender'],
    packages=['ppaextender'],
    data_files=[('share/metainfo', ['data/com.github.linuxhubit.ppaextender.appdata.xml']),
                ('share/applications', ['data/com.github.linuxhubit.ppaextender.desktop']),
                ('share/icons/hicolor/128x128/apps',['data/com.github.linuxhubit.ppaextender.svg']),
                ('share/ppaextender',['data/style.css']),
                ('lib/ppaextender',['pkexec']),
    ],
)
