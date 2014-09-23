import Development.Shake
import System.Directory
import ShakePandoc

main :: IO ()
main = shakeArgs shakeOptions $ do
  want ["all"]
  
  phony "clean" $ allHtmlTargetsBelow "." >>= liftIO . mapM_ removeFile

  phony "all" $ allHtmlTargetsBelow "." >>= need

  "//*.html" *> mdToHtmlDoc
