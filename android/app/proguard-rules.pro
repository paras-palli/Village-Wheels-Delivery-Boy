## Gson rules
# Gson uses generic type information stored in a class file when working with fields. Proguard
# removes such information by default, so configure it to keep all of it.
-dontwarn org.slf4j.impl.StaticLoggerBinder