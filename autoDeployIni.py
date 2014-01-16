#!/usr/local/bin/python

import sys, paramiko

EXPECTED_ARGS = 7

def error_file(line_one):
	print line_one
	print '     Must contain GITHUB_URL BRANCH CONTAINER_TAG LOCAL_PORT CONTAINER_PORT SSH_ADDRESS SSH_CREDENTIALS'
	print '     Migth contain at the end ENVIRONMENT_VARS'

def usage():
	print 'USAGE: config_input_file'

def execute_autoDeploy(params):
	# http://docs.paramiko.org/
	# http://code.activestate.com/recipes/576810-copy-files-over-ssh-using-paramiko/
	# http://chuwiki.chuidiang.org/index.php?title=Leer_y_escribir_ficheros_en_python
	ssh = paramiko.SSHClient()
	ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
	try:
		ssh.connect(params['SSH_ADDR'], port=params['SSH_PORT'], username=params['SSH_USER'], password=params['SSH_PASS'], key_filename=params['SSH_CREDS'])
		stdin, stdout, stderr = ssh.exec_command('ls')
		
		ssh.close()
	except BadHostKeyException:
		print 'The host key given by the SSH server did not match what we were expecting'
	except AuthenticationException:
		print 'Authentication failed for some reason'

def main():
	if (len(sys.argv) != 2):
		print usage()
	else:
		try:
			conf_file = open(sys.argv[1], 'r')
			cont = 0
			params = { 'ENVIRONMENT_VARS':'' }
			for line in conf_file:
				elems = line.split('=')
				params[elems[0]] = elems[1]
				cont += 1
			conf_file.close()
			if cont < EXPECTED_ARGS:
				error_file('ERROR: Too few values in ' + sys.argv[1])
			else:
				execute_autoDeploy(params)
		except (OSError, IOError):
			error_file('ERROR: File ' + sys.argv[1] + ' do not exists')

if __name__ == '__main__':
	main()
