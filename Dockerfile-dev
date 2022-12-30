#Build
FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /
COPY . ./
RUN cd Game && dotnet restore
RUN cd Game && dotnet build

#Run unit tests
FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /
COPY . ./
RUN cd GameTest && dotnet restore
RUN cd GameTest && dotnet test

#Copy and publish a release
FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /
COPY . ./
RUN cd Game && dotnet restore
RUN cd Game && dotnet publish -c Release -o DockerBuilds

#Build runtime image
FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /
COPY --from=2 Game/DockerBuilds .
EXPOSE 7021
ENV ASPNETCORE_URLS=http://+:7021
ENTRYPOINT ["dotnet", "KOF.dll"]
