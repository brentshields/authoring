import Development.Shake
import Development.Shake.FilePath
import ShakePandoc

opts :: ShakeOptions
opts = shakeOptions {shakeVerbosity=Quiet}

autoReloadScriptFile :: FilePath
autoReloadScriptFile = shakeFiles opts </> "auto-reload.html"

autoReloadScript :: String
autoReloadScript =
  "<script>window.onload=function(){" ++
  "setTimeout(function(){location.reload()},1000)}</script>"

main :: IO ()
main = shakeArgs opts $ do
  phony "clean" $ removeFilesAfter (shakeFiles opts) ["//*"]
  
  autoReloadScriptFile *> \out -> do
    command_ [Shell] "echo" [show autoReloadScript, ">", out]
    
  "*.html" *> \out -> do
    need [autoReloadScriptFile]
    buildHtmlFromMd ["-B", autoReloadScriptFile] out
