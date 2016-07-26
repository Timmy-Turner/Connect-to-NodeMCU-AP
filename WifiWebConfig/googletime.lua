-- retrieve the current time from Google
print("google time function")
conn=net.createConnection(net.TCP, 0) 

conn:on("connection",function(conn, payload)
     conn:send("HEAD / HTTP/1.1\r\n".. 
     "Host: google.com\r\n"..
     "Accept: */*\r\n"..
     "User-Agent: Mozilla/4.0 (compatible; esp8266 Lua;)"..
     "\r\n\r\n") 
 end)
 
conn:on("receive", function(conn, payload)
     print('\nRetrieved in '..((tmr.now()-t)/1000)..' milliseconds.')
     print('Google says it is '..string.sub(payload,string.find(payload,"Date: ")+6,string.find(payload,"Date: ")+35))
     googleTime = string.sub(payload,string.find(payload,"Date: ")+6,string.find(payload,"Date: ")+35)
     print("google time var is")
     print(googleTime)
    
     
 conn:close()
 end) 
t = tmr.now() 
conn:connect(80,'google.com') 



-- launch a http server and server the time in a html page

print("launch http server")
 
 srv=net.createServer(net.TCP)
 srv:listen(80, function(conn)
     conn:on("receive", function(conn,payload)
         print(payload)
         conn:send('<h1>Google Time</h1>')
         conn:send(' '..googleTime..'')
     
     end)
    conn:on("sent", function(conn) conn:close() end)
 end)
