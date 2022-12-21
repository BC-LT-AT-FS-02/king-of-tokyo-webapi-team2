FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
#expose port
EXPOSE 7021

#Build
WORKDIR /Game
COPY . ./
RUN dotnet restore
RUN dotnet build

#Run unit test
FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /GameTest
COPY . ./
RUN dotnet restore
RUN dotnet test
RUN dotnet publish

#Copy and publish a release
FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /
COPY . ./
RUN cd Game && dotnet restore
RUN cd Game && dotnet publish -c Release -o out

#Build runtime image
# FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /Game
COPY --from=0 /Game/out .
ENV ASPNETCORE_URLS=http://+:7021
ENTRYPOINT ["dotnet", "KOF.dll"]
