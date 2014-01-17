#!/usr/local/bin/python

import sys, paramiko

EXPECTED_ARGS = 9

def error_file(line_one):
	print line_one
	print 'The file must follow the following syntax:'
	print '   GITHUB_URL=The URL to the GIT project, without .git extension'  
	print '   BRANCH=The branch of the project to use'
	print '   CONTAINER_TAG=The tag that should be used to identify the image in Docker'
	print '   LOCAL_PORT=The port to which all request will be redirected from the container port'
	print '   CONTAINER_PORT=The port from the container that will be emitting'
	print '   SSH_ADDRESS=SSH ip address to the remote machine'
	print '   SSH_USER=SSH username to the remote machine'
	print '   SSH_CREDENTIALS=SSH key file to access said machine'
	print '   ENVIRONMENT_VARS=All environment vars that may be needed for the project'

def usage():
	print 'USAGE: [-o] configuration_file'

def exec_command_print(ssh, command):
	stdin, stdout, stderr = ssh.exec_command(command)
	for line in stdout.readlines():
		print '      stdout# ' + str(line).replace('\n', '')
	for line in stderr.readlines():
		print '      stderr# ' + str(line).replace('\n', '')

def execute_autoDeploy(params):
	ssh = paramiko.SSHClient()
	ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
	try:
		prompt = '   ' + params['SSH_USER'] + '@' + params['SSH_ADDRESS'] + '> '
		ssh_params = params['GITHUB_URL'] + ' ' + params['BRANCH'] + ' ' + params['CONTAINER_TAG']
		ssh_params += ' ' + params['LOCAL_PORT'] + ' ' + params['CONTAINER_PORT'] + ' '
		ssh_params += params['OVERRIDE'] + ' ' + params['ENVIRONMENT_VARS']

		print '> SSH connect to ' + params['SSH_USER'] + '@' + params['SSH_ADDRESS']
		ssh.connect(params['SSH_ADDRESS'], username=params['SSH_USER'], key_filename=params['SSH_CREDENTIALS'])
		print prompt + "Hello!"

		print prompt + 'sftp open'
		sftp = ssh.open_sftp()
		print prompt + 'copy autoDeploy.sh -> /tmp/autoDeploy.sh'
		sftp.put('autoDeploy.sh', '/tmp/autoDeploy.sh')
		print prompt + 'sftp close'	
		sftp.close()	
		print prompt + 'chmod 775 /tmp/autoDeploy.sh'
		exec_command_print(ssh, 'chmod 755 /tmp/autoDeploy.sh')
		print prompt + './autoDeploy.sh ' + ssh_params
		exec_command_print(ssh, '/tmp/autoDeploy.sh ' + ssh_params)
		print prompt + 'exit'
		ssh.close()

	except paramiko.BadHostKeyException:
		print 'The host key given by the SSH server did not match what we were expecting'
	except paramiko.AuthenticationException:
		print 'Authentication failed for some reason'
	except paramiko.SSHException:
		print 'Fail executing the commands'
	except Exception, e:
		print 'Exception on SSH: '
		print str(e)

def main():
	if (len(sys.argv) < 2) | (len(sys.argv) > 3):
		usage()
	else:
		try:
			path = sys.argv[1]
			options = ''
			if len(sys.argv) == 3:
				path = sys.argv[2]
				if sys.argv[1] == '-o':
					options = '-o'				

			print '> open ' + path
			conf_file = open(path, 'r')
			cont = 0
			print '> read ' + path
			params = { 'ENVIRONMENT_VARS':'', 'OVERRIDE':options }
			for line in conf_file:
				elems = line.split('=')
				params[elems[0]] = elems[1].replace('\n', '')
				cont += 1
			print '> close ' + path
			conf_file.close()

			if cont != EXPECTED_ARGS:
				error_file('ERROR: bad number of arguments in "' + path + '"')
			else:
				execute_autoDeploy(params)

		except (OSError, IOError), e:
			error_file('ERROR: File "' + path + '" do not exists')

if __name__ == '__main__':
	main()
