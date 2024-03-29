#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <libgnome/gnome-url.h>

static int
not_here(char *s)
{
	croak("%s not implemented on this architecture", s);
	return -1;
}

static double
constant(char *name, int len, int arg)
{
	errno = 0;
	if (strEQ(name + 0, "GNOME_URL_H"))
	{
		#ifdef GNOME_URL_H
			return GNOME_URL_H;
		#else
			errno = ENOENT;
			return 0;
		#endif
	}
	errno = EINVAL;
	return 0;
}

MODULE = Gnome::URL		PACKAGE = Gnome::URL		


double
constant(sv,arg)
	PREINIT:
		STRLEN len;
	INPUT:
		SV   * sv
		char * s = SvPV(sv, len);
		int    arg
	CODE:
		RETVAL = constant(s, len, arg);
	OUTPUT:
		RETVAL


void
show(url)
		const char * url
	CODE:
		gnome_url_show(url);
		

