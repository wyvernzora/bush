Promise = require('bluebird')
util    = require('util')
exec    = require('child_process').exec
chai    = require('chai')
assert  = chai.assert
should  = chai.should()
expect  = chai.expect
_       = require('underscore')

module.exports = self = { }

defaultFlags =
  infile: 'default'
  outfile: 'default'
  errfile: 'default'
  truncate: 'YES'
  bg: 'NO'

self.run = (cli, input) ->
  return new Promise (resolve, reject) ->
    exec "echo \"#{input}\" | #{cli}", (error, stdout, stderr) ->
      if (error) then reject(error);
      else resolve(stdout: self.stripAnsi(stdout), stderr: self.stripAnsi(stderr));

self.stripAnsi = (str) ->
  return str.replace(/\x1B\[[0-9;]+m/g, '')

self.checkCmdTable = (tab, cmds, flags) ->
  # Strip spaces
  tab = tab.replace(/\s+/g, ' ')
  # Check each command
  for cmd, i in cmds
    row = "INFO: #{i} " + _.chain(cmd).map((i) -> "\"#{i}\"").reduce(((mem, i) -> mem + ' ' + i)).value()
    expect(tab).to.contain(row)
  # Check flags
  flags = _.extend { }, defaultFlags, flags
  flags = "INFO: #{flags.outfile} #{flags.infile} #{flags.errfile} #{flags.truncate} #{flags.bg}"
  expect(tab).to.include(flags);