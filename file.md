Here is the full portal-only route, using Kudu's drag-and-drop zip deploy so you don't need the CLI.

## Part A: Prepare the app on your machine

1. In IntelliJ, open your Hello World project with the `HelloController` from earlier.
2. In `pom.xml`, inside `<build>`, add a fixed jar name so the file is always `app.jar`:
   ```xml
   <build>
       <finalName>app</finalName>
       <plugins> ...existing spring-boot plugin... </plugins>
   </build>
   ```
3. Build it. Open the Maven tool window and run **Lifecycle → clean**, then **package**. You'll get `target/app.jar`.
4. In File Explorer, right-click `app.jar` → **Compress to ZIP file**. You now have `app.zip` containing `app.jar`.

## Part B: Create the Web App in the portal

1. Sign in at **portal.azure.com**.
2. In the top search bar, type **App Services** and open it, then click **Create → Web App**.
3. On the **Basics** tab, fill in:
    - **Subscription**: your free one
    - **Resource group**: click **Create new**, name it `rg-hello-spring`
    - **Name**: something unique, e.g. `shiva-hello-spring-123` (this becomes your URL)
    - **Publish**: Code
    - **Runtime stack**: Java 17
    - **Java web server stack**: Java SE (Embedded Web Server)
    - **Operating System**: Linux
    - **Region**: Central India (or the nearest one that allows the free plan)
4. Under **Pricing plans**, check the Linux plan. Click **Explore pricing plans** and select **Free F1**. If Free F1 isn't offered in that region, change the region and look again.
5. Skip the **Database, Deployment, Networking, Monitor** tabs. Leave the defaults. If **Monitor + secure** shows Application Insights enabled, set it to **No**.
6. Click **Review + create → Create**. Wait about a minute until you see "Your deployment is complete", then click **Go to resource**.

## Part C: Deploy the jar from the portal( Not working for linux based resource )

1. In your Web App's left menu, scroll to **Development Tools** and click **Advanced Tools → Go →**. This opens the Kudu site in a new tab. Sign in if asked.
2. In the Kudu page, add `/ZipDeployUI` to the end of the URL, so it looks like `https://<your-app>.scm.azurewebsites.net/ZipDeployUI`.
3. **Drag and drop `app.zip`** onto the file area on that page. Wait until it shows the deployment as successful.
4. Back in the portal, open your Web App → **Overview** and click **Restart**.

## Part D: Check it and open it on your phone

1. On the **Overview** page, click the **Default domain** link (`https://<your-app>.azurewebsites.net`). Allow 30 to 60 seconds on the first load, since the free plan is slow to wake up. You should see "Hello from Azure!"
2. On your phone, type the same `https://...azurewebsites.net` address into Chrome or Safari. It works over mobile data or Wi-Fi, with no extra setup.

## If something goes wrong

- **"Application Error" or a blank page**: in the Web App, go to **Monitoring → App Service logs**, set **Application logging** to **File System**, save, then open **Monitoring → Log stream** and refresh the site.
- **Site never starts (503)**: go to **Settings → Environment variables → App settings**, add `WEBSITES_PORT` = `8080`, click **Apply**, and restart.
- **Wrong Java version error in the log**: make sure `java.version` in `pom.xml` is 17, to match the runtime you picked.

## Part E: Clean up and avoid charges

1. Search for **Resource groups** in the top bar and open `rg-hello-spring`.
2. Click **Delete resource group**, type the group name to confirm, and click **Delete**.
3. Optionally set a small alert under **Cost Management + Billing → Budgets** before you start, as a safety net.

Once this works, a good next step is **Deployment Center** in the Web App menu, which connects a GitHub repo so every push deploys automatically.