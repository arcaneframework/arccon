arccon_return_if_package_found(PETSc)

# First try to find PETSc with pkg-config

# Use pkg-config, but we have to look for the path for libraries
include(FindPkgConfig)
# Use IMPORTED_TARGET from findpkgconfig should be interesting
pkg_check_modules(PKG_PETSc PETSc)

message(STATUS "Infos from pkg_check_modules")
message(STATUS "PKG_PETSc_INCLUDE_DIRS       = ${PKG_PETSc_INCLUDE_DIRS}")
message(STATUS "PKG_PETSc_LIBRARIES          = ${PKG_PETSc_LIBRARIES}")
message(STATUS "PKG_PETSc_LIBRARY_DIRS       = ${PKG_PETSc_LIBRARY_DIRS}")

if(PKG_PETSc_FOUND)
  # Prepare results from pkg-config
  # TODO: use IMPORTED_TARGET from pkg_check_modules
  set(PETSc_LIBRARIES "")
  foreach(lib ${PKG_PETSc_LIBRARIES})
    find_library(_lib NAMES ${lib} HINTS ${PKG_PETSc_LIBDIR} ${PKG_PETSc_LIBRARY_DIRS})
    list(APPEND PETSc_LIBRARIES ${_lib})
  endforeach()

  set(PETSc_INCLUDE_DIRS ${PKG_PETSc_INCLUDE_DIRS})

else(PKG_PETSc_FOUND)
  # Manual find for PETSc
  # FIXME: legacy
  find_path(PETSc_INCLUDE_DIRS petsc.h)

  find_library(PETSc_LIB petsc)
  find_library(PETSc_KSP_LIB petscksp)
  find_library(PETSc_MAT_LIB petscmat)
  find_library(PETSc_VEC_LIB petscvec)
  find_library(PETSc_DM_LIB petscdm)

  if (PETSc_LIB)
    set(PETSc_LIBRARIES ${PETSc_LIB})
  endif()

  if (PETSc_KSP_LIB)
    list(APPEND PETSc_LIBRARIES ${PETSc_KSP_LIB})
  endif()

  if (PETSc_MAT_LIB)
    list(APPEND PETSc_LIBRARIES ${PETSc_MAT_LIB})
  endif()

  if (PETSc_VEC_LIB)
    list(APPEND PETSc_LIBRARIES ${PETSc_VEC_LIB})
  endif()

  if (PETSc_DM_LIB)
    list(APPEND PETSc_LIBRARIES ${PETSc_DM_LIB})
  endif()

endif(PKG_PETSc_FOUND)

message(STATUS "PETSc_INCLUDE_DIRS=" ${PETSc_INCLUDE_DIRS})
message(STATUS "PETSc_LIBRARIES=" ${PETSc_LIBRARIES} )

unset(PETSc_FOUND)
if (PETSc_INCLUDE_DIRS AND PETSc_LIBRARIES)
  set(PETSc_FOUND TRUE)
  arccon_register_package_library(PETSc PETSc)
endif()
