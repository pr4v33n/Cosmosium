
import requests
from bottle import route, run, request, template
import json

global OOIs
global CHUNKS

### BOTTLE.PY ROUTES ###
@route('/systemView')
def searchTest():
    return template('tpl/systemView',asteroidDB="/getAsteroids")

@route('/addAsteroid')
def addOOI():
    global OOIs
    global CHUNKS
    name = request.query.name
    OOIs.addObject(byName(name))
    print 'object '+name+' added to OOIs'
    return template('tpl/asteroidAdd',objectName=name,chunks=CHUNKS)

@route('/getAsteroids')
def getOOIs():
    global OOIs
    data = json.dumps(OOIs.MPOs)
    print data
    return template('tpl/jsAsteroids',json=data)
    
@route('/asteroidReq')
def processReq():
    q = request.query.query
    lim = request.query.limit
    print 'q=',q,' l=',lim
    return template('type: {{datatype}} (response {{res}})', datatype="asterank", res=asterankAPI(q,lim))

###    ###     ###

def byName(name):
    q = '{"full_name":"'+name+'"}'
    return asterankAPI(q,1)
        
def asterankAPI(query, limit):
    # queries the asterank API as guided by http://www.asterank.com/mpc
    # query = (regex?) specifier string
    # limit = max asteroids to return
    payload = {'query':str(query),'limit':str(limit)}
    print 'payload:',payload
    r = requests.get("http://asterank.com/api/asterank", params=payload)
    # r = requests.get("http://asterank.com/api/asterank?query="+query+"&limit="+str(limit))
#    resp = str(r.json())
#    print('json='+resp) # this actually causes us problems b/c of the u'str' unicode string notation
#   return resp
    print('text='+r.text)
    return r.text.replace("&quote;",'"')


if __name__ == "__main__":
#    resp = asterankAPI('{"e":{"$lt":0.1},"i":{"$lt":4},"a":{"$lt":1.5}}', 2)
#    print resp
    run(host='localhost', port=8080, debug=True)
