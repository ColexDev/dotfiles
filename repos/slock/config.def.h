/* user and group to drop privileges to */
#define BLUR
#define PIXELATION
static const int blurRadius = 15;
static const int pixelSize = 5;
static const char *user  = "nobody";
static const char *group = "nobody";
static const char *message = "Why Are You Looking At My Screen?";
static const char *text_color = "#ffffff";
static const char *font_name = "6x10";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "black",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 0;
