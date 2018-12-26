FROM mcr.microsoft.com/windows/nanoserver:sac2016 as build-env
LABEL maintainer="kosunix@gmail.com"

ADD https://dl.influxdata.com/influxdb/releases/influxdb-1.7.2_windows_amd64.zip /.

RUN powershell Expand-Archive influxdb-1.7.2_windows_amd64.zip -DestinationPath .

FROM mcr.microsoft.com/windows/nanoserver:sac2016 AS runtime-env

COPY --from=build-env ["/influxdb-1.7.2-1", "C:/Program Files/InfluxDB/"]

WORKDIR /Program Files/InfluxDB

# RUN powershell -command "[Environment]::SetEnvironmentVariable('Path', $env:Path + ';C:\Program Files\InfluxDB;', [EnvironmentVariableTarget]::Machine)"

ENTRYPOINT ["cmd.exe", "/k", "influxd.exe"]