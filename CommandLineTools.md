# MAC OSX terminal commands cheat list

## xxd

Use **xxd -r -p** to convert memory hex bytes into readable text.

For instance, to troubleshoot the content of a REST response buffer stored in a NSConcreteMutableData at address (0x08654860), in XCode debugger window, lldb will return:

```
(lldb) po 0x08654860
(int) $2 = 140855392 <3c3f786d 6c207665 7273696f 6e3d2231 2e302220 656e636f 64696e67 3d225554 462d3822 20737461 6e64616c 6f6e653d 22796573 223f3e0a 3c657272 6f723e0a 20203c73 74617475 733e3430 313c2f73 74617475 733e0a20 203c7469 6d657374 616d703e 31333438 37373932 38343639 323c2f74 696d6573 74616d70 3e0a2020 3c726571 75657374 2d69643e 5a353054 33593656 39583c2f 72657175 6573742d 69643e0a 20203c65 72726f72 2d636f64 653e303c 2f657272 6f722d63 6f64653e 0a20203c 6d657373 6167653e 5b756e61 7574686f 72697a65 645d2e20 54686520 746f6b65 6e207573 65642069 6e207468 65204f41 75746820 72657175 65737420 6973206e 6f742076 616c6964 2e203937 66616538 34352d34 6537622d 34343537 2d613663 312d3766 36383036 39653639 38363c2f 6d657373 6167653e 0
```

To convert it, use the command:

```
echo "3c3f786d 6c207665 7273696f 6e3d2231 (...)" | xxd -r -p
```

and you get:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<error>
  <status>401</status>
  <timestamp>1348779284692</timestamp>
  <request-id>Z50T3Y6V9X</request-id>
  <error-code>0</error-code>
  <message>[unauthorized]. The token used in the OAuth request is not valid. 97fae845-4e7b-4457-a6c1-7f68069e6986</message>
</error>
```

## python

Very quickly share a file with someone. In the folder containing the file(s), run

```
python -m SimpleHTTPServer
```

you get:

```
Serving HTTP on 0.0.0.0 port 8000 ...
```

all files in the folder are now accessible though http://yourIP:8000/

## open

open finder from the terminal at the current folder:

```
open .
```

Tired of vi, open a file in default text editor from the terminal:

```
open -t file.txt
```

Specify different app:

```
open -a "Sublime Text 2" file.txt
```

## curl by example

I really need to write this one...

### GET

Simple GET

```
curl http://www.strava.com/api/v2/rides/22050558
```

result:

```json
{
    "id":"22050558",
    "ride":
    {
        "id":22050558,
        "name":"BBC 100 - wheelsucker mode",
        "start_date_local":"2012-09-15T07:55:28Z",
        "elapsed_time":16220,
        "moving_time":16182,
        "distance":164942.0,
        "average_speed":10.192930416512175,
        "elevation_gain":1243.6,
        "location":"Cartersville, GA",
        "start_latlng":[34.253977769985795,-84.78729735128582],
        "end_latlng":[34.25395907834172,-84.78736960329115]
    },
    "version":"1347734144"
}
```

### POST 

Post url encoded data (-d or --data flag), in this case login to a Strava REST service:

```
curl -X POST -d "email=xxx@xxx.com" -d "password=xxxxxx" https://www.strava.com/api/v2/authentication/login
```

response:

```json
{
    "token":"ffffffffffffffff",
    "athlete":
    {
        "id":12405,
        "name":"S\u00e9bastien Windal",
        "agreed_to_terms":true,
        "super_user":false,
        "iphone_tester":false,
        "push_token":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
        "default_settings":
        {
            "sample_rate":3,
            "continuous_gps":true,
            "accuracy":0,
            "distance_filter":3,
            "max_search_time":30,
            "min_stale_time":300,
            "min_accuracy":150,
            "map_threshold":25,
            "max_sync_time":60,
            "max_waypoint_stale_time":300,
            "update_ride_poll_interval":2
        }
    },
    "activity_data":[]
}
```

Post Form data (useful to upload file) --form or -F flag:

```
curl --form "fileupload=@filename.txt" http://example.com/resource.cgi
```


## tcpdump

TODO