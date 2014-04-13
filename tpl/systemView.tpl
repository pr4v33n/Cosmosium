<!DOCTYPE html>
<html lang="en">
    <head>
        <title>three.js webgl - orbit controls</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
        <style>
            body {
                color: #000;
                font-family:Monospace;
                font-size:13px;
                text-align:center;
                font-weight: bold;

                background-color: #fff;
                margin: 0px;
                overflow: hidden;
            }

            #info {
                color:#000;
                position: absolute;
                top: 0px; width: 100%;
                padding: 5px;

            }

            a {
                color: red;
            }

            #body-info-container {
                background-color: gray;
                color: white;
                position: absolute;
                top: 0px; 
                right: 0px;
                width: 200px;
                padding: 5px;
            }

            #body-info {
                

            }
        </style>
    </head>

    <body>

        <script type="application/x-glsl" id="sky-vertex">
        varying vec2 vUV;

        void main() {
          vUV = uv;
          vec4 pos = vec4(position, 1.0);
          gl_Position = projectionMatrix * modelViewMatrix * pos;
        }
        </script>

        <script type="application/x-glsl" id="sky-fragment">
        uniform sampler2D texture;
        varying vec2 vUV;

        void main() {
          vec4 sample = texture2D(texture, vUV);
          gl_FragColor = vec4(sample.xyz, sample.w);
        }
        </script>

        <div id="container"></div>

        <script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>

        <script type="text/javascript" src="js/vendor/ces-browser.min.js"></script>

        <script src="js/vendor/three.min.js"></script>

        <script src="js/vendor/OrbitControls.js"></script>

        <script src="js/vendor/Detector.js"></script>
        <script src="js/vendor/stats.min.js"></script>

        <script src={{asteroidDB}}></script> 
        
        <script src="db/OOIs.js"></script>

        <script src="js/util.js"></script>
        <script src="js/ellipse.js"></script>
        <script src="js/ephemeris.js"></script>
        <script src="js/main.js"></script>

        <div id="body-info-container">
            <a id="claim-asteroid-button" href="#">Claim this asteroid</a>
            <div id="body-info">foo</div>
        </div>

    </body>
</html>