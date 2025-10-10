#!/usr/bin/env python
from subprocess import check_output

def get_gmail_pass(account):
    return check_output("gmail-app-credentials pass " + account, shell=True).splitlines()[0]
