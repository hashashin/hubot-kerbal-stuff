# Description
#   Ask hubot for Kerbal Space Program mods
#
# Configuration:
#   HUBOT_KS_API_URL Kerbalstuff api url, defaults to https://kerbalstuff.com/api (just in case someday is changed)
#   HUBOT_KS_MAX_RESULTS Max results to respond in chat, defaults to 5
#
# Commands:
#   hubot ks find <query> - Search in Kerbalstuff the given word
#   hubot ks top - Show top mods in Kerbalstuff
#   hubot ks mew - Show new mods in Kerbalstuff
#   hubot ks featured - Show featured mods in Kerbalstuff
#
# Author:
#   hashashin <gentoo.power@gmail.com>

api_url = process.env.HUBOT_KS_API_URL || "https://kerbalstuff.com/api"
maxresults = process.env.HUBOT_KS_MAX_RESULTS || 5

module.exports = (robot) ->
  robot.respond /ks find(?:\s+(.*))?$/i, (msg) ->
    query = msg.match[1]
    msg.http("#{api_url}/search/mod?query=#{query}")
      .get() (err, res, body) ->
        try
          json = JSON.parse(body)
          if json.length >= maxresults
            for mod in [maxresults..0]
              msg.send "#{json[mod].name} by #{json[mod].author} -- ksp:#{json[mod].versions[0].ksp_version} -- url: https://kerbalstuff.com/mod/#{json[mod].id}"
          else 
            for mod in json
              msg.send "#{mod.name} by #{mod.author} ksp:#{mod.versions[0].ksp_version} -- url: https://kerbalstuff.com/mod/#{mod.id}"
        catch err
          msg.send err

  robot.respond /ks top/i, (msg) ->
    msg.http("#{api_url}/browse/top")
      .get() (err, res, body) ->
        try
          json = JSON.parse(body)
          for mod in [maxresults..0]
            msg.send "#{json[mod].name} by #{json[mod].author} -- ksp:#{json[mod].versions[0].ksp_version} -- url: https://kerbalstuff.com/mod/#{json[mod].id}"
        catch err
          msg.send err

  robot.respond /ks new/i, (msg) ->
    msg.http("#{api_url}/browse/new")
      .get() (err, res, body) ->
        try
          json = JSON.parse(body)
          for mod in [maxresults..0]
            msg.send "#{json[mod].name} by #{json[mod].author} -- ksp:#{json[mod].versions[0].ksp_version} -- url: https://kerbalstuff.com/mod/#{json[mod].id}"
        catch err
          msg.send err

  robot.respond /ks featured/i, (msg) ->
    msg.http("#{api_url}/browse/featured")
      .get() (err, res, body) ->
        try
          json = JSON.parse(body)
          for mod in [maxresults..0]
            msg.send "#{json[mod].name} by #{json[mod].author} -- ksp:#{json[mod].versions[0].ksp_version} -- url: https://kerbalstuff.com/mod/#{json[mod].id}"
        catch err
          msg.send err
