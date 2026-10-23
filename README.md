# DeathCVLT Telegram Mini App

Dark-blue, early-2010s underground-inspired Telegram Mini App starter, designed for deployment to GitHub + Vercel.

## Included
- Responsive Telegram Mini App UI and desktop fallback\n- Animated 3D-style card depth and smoother retro transitions\n- Animated audio waveform while a demo track is playing\n- One-tap dark/light theme toggle (saved in browser)
- Main screen using the supplied city background and original transparent logo
- News, demo centre, application form and account/status screen
- Admin panel UI for reviewing applications and managing news/demo entries
- Vercel serverless API endpoints (`/api/applications`, `/api/news`, `/api/demos`, `/api/notify`)
- Supabase SQL schema for persistent storage
- Telegram Bot API notifications when configured

> Security note: the UI works in preview mode without credentials. For production, configure Supabase and Telegram environment variables. Admin API requests require `x-admin-password`. Never put bot tokens or service-role keys in frontend variables.

## Run locally
1. Install Node.js 20+.
2. Copy `.env.example` to `.env` and fill in the values.
3. Run `npm install`, then `npm run dev`.
4. Open the shown local URL.

## GitHub + Vercel deployment
1. Create a GitHub repository and upload this project.
2. Import the repository into Vercel. Framework preset: **Vite**; build command `npm run build`; output directory `dist`.
3. Add environment variables from `.env.example` in Vercel Project Settings → Environment Variables.
4. Create a Supabase project and run `supabase/schema.sql` in SQL Editor.
5. Set `TELEGRAM_BOT_TOKEN`, `TELEGRAM_BOT_USERNAME`, `ADMIN_PASSWORD`, `SUPABASE_URL`, and `SUPABASE_SERVICE_ROLE_KEY` in Vercel.
6. In BotFather, configure the bot's menu button to the deployed Vercel URL. Example command: `/setmenubutton`, then choose your bot, title `Открыть DeathCVLT`, and the HTTPS URL.
7. Set bot webhook to `https://api.telegram.org/bot<TELEGRAM_BOT_TOKEN>/setWebhook?url=https://YOUR-DOMAIN/api/telegram-webhook&secret_token=YOUR_TELEGRAM_WEBHOOK_SECRET`. This webhook is optional for this first UI version; user opens Mini App via menu button.
8. Redeploy after adding variables.

## Telegram notifications
Telegram bots can only DM a user after the user has started the bot. The app asks Telegram for the user's ID when opened inside Telegram and sends it with an application. Configure the bot token on Vercel. The server-side notification endpoint can send status/release messages when a Telegram chat ID is known.

## Admin panel
Open the app and choose `ADMIN` in the navigation, then enter the password configured as `ADMIN_PASSWORD`. The browser stores the password for this session only. Keep the password private. For a production multi-admin team, replace this simple shared-password flow with Telegram Login Widget / Supabase Auth and add rate limiting.

## Notes
- Without Supabase environment variables, the app runs in demo mode and keeps changes in browser local storage. This is for preview only; local storage is not shared across users or devices.
- News and demo upload UI accepts text and image/audio file selection. In the starter version, file data is held in browser state/local storage; production uploads should be wired to Supabase Storage before large media files are published.
