FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["src/SimpleApi/SimpleApi.csproj", "./"]
RUN dotnet restore "./SimpleApi.csproj"
COPY "src/SimpleApi/" .
WORKDIR "/src/."
RUN dotnet build "SimpleApi.csproj" -c Release -o /app/build
FROM build AS publish
RUN dotnet publish "SimpleApi.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SimpleApi.dll"]