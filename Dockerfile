FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
ENV ASPNETCORE_URLS=http://+:7021

EXPOSE 7021

COPY . .
WORKDIR /Game
RUN dotnet restore
RUN dotnet publish -c Release -o DockerBuilds
WORKDIR /Game/DockerBuilds
ENTRYPOINT ["dotnet", "KOF.dll"]
