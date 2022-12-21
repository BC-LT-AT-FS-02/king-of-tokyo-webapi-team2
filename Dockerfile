#Build
FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /Game
COPY . .
RUN dotnet restore
RUN dotnet build

#Run unit tests
FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /GameTest
COPY . .
RUN dotnet restore
RUN dotnet test
RUN dotnet publish

#Copy and publish a release
FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /Game
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o DockerBuilds

#Build runtime image
FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /
COPY --from=2 /Game/DockerBuilds .
EXPOSE 7021
ENV ASPNETCORE_URLS=http://+:7021
ENTRYPOINT ["dotnet", "KOF.dll"]
