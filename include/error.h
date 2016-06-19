#ifndef _ERROR_H
#define _ERROR_H 1
#endif

#include <errno.h>

#define error(status, errnum, message, ...) perror(message); exit(status);
