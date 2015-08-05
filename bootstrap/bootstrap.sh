#!/bin/sh

( umask 022 &&
	ansible-playbook -i localhost bootstrap.yml )
