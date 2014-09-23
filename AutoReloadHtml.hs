import Development.Shake
import Development.Shake.FilePath
import ShakePandoc

opts :: ShakeOptions
opts = shakeOptions

main :: IO ()
main = shakeArgs opts $ do
  want ["all"]
  
  phony "clean" $ removeFilesAfter "." ["//*" ++ genHtmlExt]

  phony "all" $ do
    outs <- fmap (map $ flip replaceExtension genHtmlExt) $ allMdFilesBelow "."
    need outs

  "//*" ++ genHtmlExt *> mdToHtmlDoc
