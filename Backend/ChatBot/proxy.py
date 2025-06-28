from fastapi import FastAPI, Request, Response
import httpx
import logging
import uvicorn

app = FastAPI()
logging.basicConfig(level=logging.INFO)

@app.api_route("/{bot}/webhook", methods=["POST", "GET"])
async def proxy_webhook(bot: str, request: Request):
    if bot == "student":
        target_url = "http://localhost:8002/webhook"
    elif bot == "teacher":
        target_url = "http://localhost:8001/webhook"
    else:
        return Response(content="Invalid bot name", status_code=400)

    try:
        body = await request.body()
        headers = dict(request.headers)
        headers["host"] = "localhost"

        async with httpx.AsyncClient() as client:
            proxied_response = await client.request(
                method=request.method,
                url=target_url,
                headers=headers,
                content=body
            )

        return Response(
            content=proxied_response.content,
            status_code=proxied_response.status_code,
            media_type="application/json"
        )

    except Exception as e:
        logging.exception("Proxy error:")
        return Response(content=f"Proxy failed: {e}", status_code=500)
    
if __name__ == '__main__':
    uvicorn.run(app, host="0.0.0.0", port=8000)
