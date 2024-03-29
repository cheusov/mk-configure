USE_VARIABLES += USE_AWK
USE_AWK.descr = "AWK interpreter"
USE_AWK.0 = 'unset or "auto":  path to AWK interpreter is detected automatically'
USE_AWK.1 = "path: the specified path to AWK interpreter is used"

USE_VARIABLES += USE_ID
USE_ID.descr = "POSIX-compatible id(1)"
USE_ID.0 = 'unset or "auto":  path to id(1) is detected automatically'
USE_ID.1 = "path: the specified path to id(1) is used"

USE_VARIABLES += USE_INSTALL
USE_INSTALL.descr = "install(1) utility"
USE_INSTALL.0 = 'unset or "auto":  path to install(1) is detected automatically'
USE_INSTALL.1 = '"mkc_install":  use local mkc_install utility'
USE_INSTALL.2 = "path: the specified path to install(1) is used"

USE_VARIABLES += USE_NM
USE_NM.descr = "List symbols from object files"
USE_NM.0 = 'unset or "auto":  path to nm(1) is detected automatically'
USE_NM.1 = "path: the specified path to nm(1) is used"

USE_VARIABLES += USE_SH
USE_SH.descr = "Shell interpreter"
USE_SH.0 = 'unset or "auto":  path to shell interpreter is detected automatically'
USE_SH.1 = "path: the specified path to shell interpreter is used"

USE_VARIABLES += USE_CC_COMPILERS
USE_CC_COMPILERS.descr = 'A list of C compilers for which initial settings are generated'
USE_CC_COMPILERS.0 = 'unset: default C compiler only'
USE_CC_COMPILERS.1 = 'list: example -- gcc-4.8 gcc-6 clang'

USE_VARIABLES += USE_CXX_COMPILERS
USE_CXX_COMPILERS.descr = 'A list of C++ compilers for which initial settings are generated'
USE_CXX_COMPILERS.0 = 'unset: default C++ compiler only'
USE_CXX_COMPILERS.1 = 'list: example -- g++-4.8 g++-6 clang++'

USE_VARIABLES += USE_CC
USE_CC.descr = 'Default C compiler'
USE_CC.0 = 'unset or "auto":  "cc"'
USE_CC.1 = 'path: path or name of the C compiler'

USE_VARIABLES += USE_CXX
USE_CXX.descr = 'Default C++ compiler'
USE_CXX.0 = 'unset or "auto":  "c++"'
USE_CXX.1 = 'path: path or name of the C++ compiler'

USE_VARIABLES += USE_CPP
USE_CPP.descr = 'Default C++ compiler'
USE_CPP.0 = 'unset or "auto":  "cpp"'
USE_CPP.1 = 'path: path or name of the C preprocessor'
