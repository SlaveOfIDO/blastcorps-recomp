#ifndef __SSB_TRACE_H__
#define __SSB_TRACE_H__

#include <stdio.h>

#define TRACE_ENTRY() \
    static int was_called = 0; \
    static int was_returned = 0; \
    if (was_called == 0) { \
        fprintf(stderr, "<%s>\n", __func__); \
        was_called = 1; \
    }
#define TRACE_RETURN() \
    if (was_returned == 0) {                   \
        fprintf(stderr, "</%s>\n", __func__); \
        was_returned = 1;                      \
    }
#define TRACE_MEMWRITE() ((void*))
#define TRACE_MEMREAD() ((void*))



#endif // __SSB_TRACE_H__