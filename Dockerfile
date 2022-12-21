FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
#Run unit test
WORKDIR /GameTest
COPY . ./
RUN dotnet test
RUN dotnet publish
#expose port
EXPOSE 7021
#Copy, build, and publish a release
FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /
COPY . ./
RUN cd Game && dotnet restore
RUN cd Game && dotnet publish -c Release -o out

#Build runtime image
FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /
COPY --from=build-env /Game/out .
ENV ASPNETCORE_URLS=http://+:7021
ENTRYPOINT ["dotnet", "KOF.dll"]
