FROM mcr.microsoft.com/dotnet/aspnet:11.0 AS base
WORKDIR /app
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:11.0 AS build
WORKDIR /src
COPY ["Phúc Nguyễn Slide.csproj", "./"]
RUN dotnet restore "Phúc Nguyễn Slide.csproj"
COPY . .
RUN dotnet build "Phúc Nguyễn Slide.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Phúc Nguyễn Slide.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Phúc Nguyễn Slide.dll"]