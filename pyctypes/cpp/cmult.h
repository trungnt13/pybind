#ifdef _MSC_VER
#define EXPORT_SYMBOL __declspec(dllexport)
#else
#define EXPORT_SYMBOL
#endif

EXPORT_SYMBOL extern double myfloat;
EXPORT_SYMBOL extern long long myint;
EXPORT_SYMBOL extern float cmult(int int_param, float float_param);
