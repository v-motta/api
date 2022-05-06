FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build-env

WORKDIR /app

COPY . .
RUN dotnet restore 
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:3.1
WORKDIR /app
COPY --from=build-env /app/out .

ARG ARG_VERSION
ARG ARG_BUILD

ENV CNT_VERSION=$ARG_VERSION
ENV CNT_BUILD=$ARG_BUILD

EXPOSE 80
ENTRYPOINT ["dotnet", "application.dll"]
