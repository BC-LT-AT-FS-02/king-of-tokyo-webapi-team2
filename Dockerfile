FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
#unit test
WORKDIR /GameTest
COPY . ./
RUN dotnet test
RUN dotnet publish
#expose port
EXPOSE 7021
#copy and build
COPY . .
WORKDIR /Game
RUN dotnet restore
RUN dotnet publish -c Release -o DockerBuilds

#build runtime image
WORKDIR /Game/DockerBuilds
ENV ASPNETCORE_URLS=http://+:7021
ENTRYPOINT ["dotnet", "KOF.dll"]
